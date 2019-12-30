CREATE TABLE `t_redpack_detail`
(
    `id`         bigint(20)     NOT NULL COMMENT '主键',
    `amount`     decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '金额',
    `user_id`    bigint(20)     NOT NULL DEFAULT '0' COMMENT '用户编号',
    `redpack_id` bigint(20)     NOT NULL DEFAULT '0' COMMENT '红包编号',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;