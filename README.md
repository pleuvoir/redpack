



抢红包系统的实现方案。



## 流程说明

本项目提供了两个接口：

1. 发红包
2. 抢红包

## 方案说明

#### 基于分布式锁的实现

![分布式锁抢红包](https://github.com/pleuvoir/redpack/blob/master/docs/%E5%88%86%E5%B8%83%E5%BC%8F%E9%94%81%E6%8A%A2%E7%BA%A2%E5%8C%85.jpg)

#### 基于乐观锁的实现

![基于乐观锁的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%E4%B9%90%E8%A7%82%E9%94%81%E6%8A%A2%E7%BA%A2%E5%8C%85.jpg)

#### 基于悲观锁的实现

![基于悲观锁的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%e6%82%b2%e8%a7%82%e9%94%81%e6%8a%a2%e7%ba%a2%e5%8c%85.jpg)

#### 预先分配红包，基于乐观锁的实现

![预先分配红包，基于乐观锁的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%E9%A2%84%E5%85%88%E5%88%86%E9%85%8D%E7%BA%A2%E5%8C%85%EF%BC%8C%E5%9F%BA%E4%BA%8E%E4%B9%90%E8%A7%82%E9%94%81.jpg)

#### 基于Redis队列的实现

![基于Redis队列的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%E5%9F%BA%E4%BA%8ERedis%E9%98%9F%E5%88%97.jpg)

其中，用户发放红包时会创建相应数量的红包，并且加入到Redis队列中。

#### 基于Redis队列，异步入库

![基于Redis队列的实现](https://github.com/pleuvoir/redpack/blob/master/docs/%e5%9f%ba%e4%ba%8eRedis%e9%98%9f%e5%88%97%ef%bc%8c%e5%bc%82%e6%ad%a5%e5%85%a5%e5%ba%93.jpg)

## How-tos

* [如何准备环境](https://github.com/pleuvoir/redpack/blob/master/docs/Environment.md)
* [如何Benchmark](https://github.com/pleuvoir/redpack/blob/master/docs/Benchmark.md)

