CREATE TABLE `t_redpack_activity`
(
    `id`         bigint(20)     NOT NULL COMMENT '主键',
    `total_amount`     decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '总金额',
    `surplus_amount`     decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '剩余金额',
    `total` bigint(20)     NOT NULL DEFAULT '0' COMMENT '红包总数',
    `surplus_total` bigint(20)     NOT NULL DEFAULT '0' COMMENT '红包剩余总数',
    `user_id`    bigint(20)     NOT NULL DEFAULT '0' COMMENT '用户编号',
    `version` bigint(20)     NOT NULL DEFAULT '0' COMMENT '版本号',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
