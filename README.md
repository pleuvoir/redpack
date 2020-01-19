



抢红包系统的实现方案。



## 流程说明

本项目提供了两个接口：

1. 发红包
2. 抢红包

## 方案说明

#### 基于分布式锁的实现

![分布式锁抢红包](https://github.com/pleuvoir/redpack/blob/master/docs/%E5%88%86%E5%B8%83%E5%BC%8F%E9%94%81%E6%8A%A2%E7%BA%A2%E5%8C%85.jpg)

基于分布式锁的实现最为简单粗暴，整个抢红包接口以`activityId`作为key进行加锁，保证同一批红包抢行为都是串行执行。分布式锁的实现是由`spring-integration-redis`工程提供，核心类是`RedisLockRegistry`。锁通过Redis的lua脚本实现，且实现了阻塞式本地可重入。

#### 基于乐观锁的实现

![基于乐观锁的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%E4%B9%90%E8%A7%82%E9%94%81%E6%8A%A2%E7%BA%A2%E5%8C%85.jpg)

第二种方式，为红包活动表增加乐观锁版本控制，当多个线程同时更新同一活动表时，只有一个clien会成功。其它失败的client进行循环重试，设置一个最大循环次数即可。此种方案可以实现并发情况下的处理，但是冲突很大。因为每次只有一个人会成功，其他client需要进行重试，即使重试也只能保证一次只有一个人成功，因此TPS很低。当设置的失败重试次数小于发放的红包数时，可能导致最后有人没抢到红包，实际上还有剩余红包。

#### 基于悲观锁的实现

![基于悲观锁的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%e6%82%b2%e8%a7%82%e9%94%81%e6%8a%a2%e7%ba%a2%e5%8c%85.jpg)

由于红包活动表增加乐观锁冲突很大，所以可以考虑使用使用悲观锁：`select * from t_redpack_activity where id = #{id} for update`，注意悲观锁必须在事务中才能使用。此时，所有的抢红包行为变成了串行。此种情况下，悲观锁的效率远大于乐观锁。

#### 预先分配红包，基于乐观锁的实现

![预先分配红包，基于乐观锁的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%E9%A2%84%E5%85%88%E5%88%86%E9%85%8D%E7%BA%A2%E5%8C%85%EF%BC%8C%E5%9F%BA%E4%BA%8E%E4%B9%90%E8%A7%82%E9%94%81.jpg)

可以看到，如果我们将乐观锁的维度加在红包明细上，那么冲突又会降低。因为之前红包明细是用户抢到后才创建的，那么现在需要预先分配红包，即创建红包活动时即生成N个红包，通过状态来控制可用/不可用。这样，当多个client抢红包时，获取该活动下所有可用的红包明细，随机返回其中一条然后再去更新，更新成功则代表用户抢到了该红包，失败则代表出现了冲突，可以循环进行重试。如此，冲突便被降低了。

#### 基于Redis队列的实现

![基于Redis队列的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%E5%9F%BA%E4%BA%8ERedis%E9%98%9F%E5%88%97.jpg)

和上一个方案类似，不过，用户发放红包时会创建相应数量的红包，并且加入到Redis队列中。抢红包时会将其弹出。Redis队列很好的契合了我们的需求，每次弹出都不会出现重复的元素，用完即销毁。缺陷：抢红包时一旦从队列弹出，此时系统崩溃，恢复后此队列中的红包明细信息已丢失，需要人工补偿。

#### 基于Redis队列，异步入库

![基于Redis队列的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%e5%9f%ba%e4%ba%8eRedis%e9%98%9f%e5%88%97%ef%bc%8c%e5%bc%82%e6%ad%a5%e5%85%a5%e5%ba%93.jpg)

这种方案的是抢到红包后不操作数据库，而是保存持久化信息到Redis中，然后返回成功。通过另外一个线程`UserRedpackPersistConsumer`，拉取持久化信息进行入库。需要注意的是，此时的拉取动作如果使用普通的pop仍然会出现crash point的问题，所以考虑到可用性，此处使用Redis的`BRPOPLPUSH`操作，弹出元素后加入备份到另外一个队列，保证此处崩溃后可以通过备份队列自动恢复。崩溃恢复线程`CrashRecoveryThread`通过定时拉取备份信息，去DB中查证是否持久化成功，如果成功则清除此元素，否则进行补偿并清除此元素。如果在操作数据库的过程中出现异常会记录错误日志`redpack.persist.log`，此日志使用单独的文件和格式，方便进行补偿（一般不会触发）。

## QA

1. Redis挂了怎么办？

Redis做高可用。

2. 红包算法使用的什么？

此工程主要展示抢红包系统的设计，红包算法不是重点，所以没有二倍均值法之类的实现。

## How-tos

* [如何准备环境](https://github.com/pleuvoir/redpack/blob/master/docs/Environment.md)
* [如何Benchmark](https://github.com/pleuvoir/redpack/blob/master/docs/Benchmark.md)

