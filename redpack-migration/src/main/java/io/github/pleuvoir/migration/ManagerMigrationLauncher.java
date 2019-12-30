package io.github.pleuvoir.migration;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.flyway.FlywayAutoConfiguration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication(exclude = {FlywayAutoConfiguration.class})
public class ManagerMigrationLauncher {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(ManagerMigrationLauncher.class);
        application.run(args);
    }
}
