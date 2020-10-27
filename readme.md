Demo of Spring Petclinic compiled Ahead of Time via GraalVM Native Image. 

This repo supports 3 databases, they are:
1. Oracle 19c Enterprise
2. MySQL 8.0
3. H2 v1.4.200

To switch to between databases you can modify below properties inside `application.properties` file.

```
# select database to choose from, it supports H2, MySQL and Oracle (tested with Oracle 19c Enterprise)
# values either:
#     h2, mysql, oracle
database=oracle
```
    
Uncomment selected database, in our case above we choose Oracle database.

```
# Spring datasource settings - H2 - Uncomment below line if you are using H2
# =====================================================================================
#spring.datasource.url=jdbc:h2:mem:petclinic
#spring.datasource.driver-class-name=org.h2.Driver
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.username=sa
#spring.datasource.password=password
# To enable H2 console, uncomment below line, and then you can navigate to http://localhost:8080/h2-console
#spring.h2.console.enabled=true


# Spring datasource settings - MySQL - Uncomment below line if you are using MySQL
# =====================================================================================
#spring.datasource.url=jdbc:mysql://${MYSQL_HOST:localhost}:3306/petclinic?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true
#spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
#spring.datasource.username=petclinic
#spring.datasource.password=petclinic


# Spring datasource and JPA settings - Oracle - Uncomment below line if you are using Oracle
# ============================================================================================
spring.datasource.url=jdbc:oracle:thin:@//${ORACLE_HOST:localhost}:1521/orcl
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
spring.jpa.database-platform=org.hibernate.dialect.Oracle12cDialect
spring.datasource.username=system
spring.datasource.password=oracle
spring.datasource.continue-on-error=true
```

This repo has been tested with GraalVM Enterprise v20.2.0 for JDK 8 using various OSes:
1. macOS Catalina 10.15.7
2. Oracle Linux 8.2
3. Ubuntu 20.4 LTS
4. Fedora 32

To build Native Image binary executable of Petclinic execute below shell script
```
./compile.sh
```

To build Native Image binary executable of Petclinic and create a Docker image of it, you just need to execute shell script
```
./build.sh
```

I also provide multi-stage docker builds should you are running on macOS (like myself) to target Linux OS. However the compile time is way longerrrrrr..
```
./build-on-docker.sh
```

Enjoy the lightning speed start up time of native image Petclinic :-)


Thanks,

Marthen Luther

(16 October 2020) - First commit only support MySQL database.

(27 October 2020) - Updated to include Oracle and H2 databases.
