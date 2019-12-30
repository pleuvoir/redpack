package io.github.pleuvoir.redpack.model.dto;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 异步持久化
 * @author <a href="mailto:fuwei@daojia-inc.com">pleuvoir</a>
 */
@Data
public class RedpackPersistDTO implements Serializable {

    private Long id;

    private Long activityId;

    private BigDecimal amount;

    private Integer status;

    private Integer version;

    private Long userId;

    private LocalDateTime createTime;
}
