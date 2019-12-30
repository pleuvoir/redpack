CREATE TABLE `t_redpack`
(
    `id`         bigint(20)     NOT NULL COMMENT '主键',
    `activity_id`         bigint(20)     NOT NULL DEFAULT 0 COMMENT '红包活动ID',
    `amount`     decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '金额',
    `status`     TINYINT(4) NOT NULL DEFAULT 0 COMMENT '红包状态 1可用 2不可用',
    `version` bigint(20)     NOT NULL DEFAULT '0' COMMENT '版本号',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
