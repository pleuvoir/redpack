## 准备环境

### 安装JDK8

下载 [jdk8](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

### 安装mysql

本实验使用的版本为`5.7`有条件的话可以选择与其保持一致。

下载[mysql](https://dev.mysql.com/downloads/mysql/5.7.html#downloads)

### 执行迁移脚本

创建数据库`redpack`，`username/password`均设置为`redpack`；

打开`redpack-migration项目`，找到`ManagerMigrationLauncher`类运行启动。如果没有报错，在终端输入`baseline`，回车后再次输入`migrate`；如果正常，此时可以发现数据库`redpack`中多了4张表。



