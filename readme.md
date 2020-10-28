**Demo of Spring Petclinic compiled Ahead of Time via GraalVM Native Image.** 

During interaction with friends, I often get asked GraalVM Native Image support for Spring Boot. 
Spring Boot and GraalVM have been collaborating to make that integration happening. 

Spring Boot has their spring-graalvm-native experimental project here https://github.com/spring-projects-experimental/spring-graalvm-native 

My repo is fork of it with some enhancements.

Below are the enhacements I did.

## Suported Databases

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

## Standard JDBC drivers

I am using a standard JDBC drivers from upstream Maven Central Repository. You can take a look at my ``pom.xml`` file for more detail. 

```
        <!-- Databases -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>com.oracle.ojdbc</groupId>
            <artifactId>ojdbc8</artifactId>
            <version>19.3.0.0</version>
        </dependency>
``` 

## Connection Pool

As an addition to supporting multiple databases, this repo is also uses Hikari connection pool which also configured in ``application.properties`` file.

```
# Hikari connection pool settings
# Detail configurations and its description can be found here
#        https://github.com/brettwooldridge/HikariCP
spring.datasource.hikari.minimumIdle=5
spring.datasource.hikari.maximumPoolSize=20
spring.datasource.hikari.idleTimeout=30000
spring.datasource.hikari.maxLifetime=2000000
spring.datasource.hikari.connectionTimeout=30000
spring.datasource.hikari.poolName=HikariPetclinicNativeImage
```

## Supported Operating Systems

This repo has been tested with GraalVM Enterprise v20.2.0 for JDK 8 using various OSes:
1. macOS Catalina 10.15.7
2. Oracle Linux 8.2
3. Ubuntu 20.4 LTS
4. Fedora 32

## How to Generate Native Image Binary Executable

You will need Maven v3.6.x, GraalVM Enterprise 20.2 for JDK 8 (it should work for GraalVM Community edition too),
and Native Image prerequisite installed.

I have wrote a tutorial as part of my previous GraalVM hands-on lab to get your environment native-image-ready. See this URL https://github.com/marthenlt/graalvm-japac-hands-on-lab-02092020#exercise-2-graalvm-enterprise 

Once your environment is native-image-ready, you can start AOT (Ahead of Time) compiling your Petclinic JPA application. 

##### Build Native Image binary executable 

Execute below script

```
./compile.sh
```

In my Mac the above script took around 9 minutes. So once you execute `compile.sh` script, you can grab a coffee :-)

##### Build Native Image binary using multi-stage docker build

I also provide multi-stage docker builds should you are running on macOS (like myself) to target Alpine Linux OS to produce small base image. 

```
./build-on-docker.sh
```
However the compile time for multi-stage docker build is way longer because the compilation is happening inside a docker image.  
I suggest to give an adequate resources for Docker.
In my Mac it took around 21 minutes to complete.

Once AOT compilation is finished, you can find the Petclinic native binary executable called ``petclinic-jpa`` inside ``target`` folder.

You can run it directly ``target/petclinic-jpa`` or via a Docker command or even deployed into Kubernetes cluster.


## Deployed the Petclinic Native Binary Executable as Kubernetes standard Pod Deployment

I have provided necessary Kubernetes deployment descriptors under ``kubernetes`` folder. Here what's inside of ``kubernetes`` folder.

```
├── kubernetes
│   ├── cleanup.sh
│   ├── delete-all-evicted-pods.sh
│   ├── deploy-petclinic-native-as-knative-service.sh
│   ├── deploy-petclinic-native-as-standard-pod.sh
│   ├── external-mysql-svc.yaml
│   ├── istio-minimal-operator.yaml
│   ├── knative-serving.yaml
│   ├── mysql-deployment.yaml
│   ├── mysql-pv.yaml
│   ├── petclinic-app-deployment.yaml
│   └── readme.md
``` 

I have wrote a shell script to automate the deployment for you.

Just execute below shell script to deploye Petclinic binary executable on your Kubernetes cluster. Do keep note that the Petclinic image is pulling from my docker hub here ``marthenl/petclinic-mysql-native-image:0.8``
 
```
cd kubernetes
./deploy-petclinic-native-as-standard-pod.sh 
```

## Deployed the Petclinic Native Binary Executable as Knative Service

One of best use case for GraalVM Native Image is lightning start up, because it doesn't need a warm up. It can handle ton of requests almost instantaneously.
A lightning start up attribute offered by GraalVM Native Image is best suite for Serverless / Function as a Service (FaaS) kind of application.

Knative is a well-known FaaS framework for Kubernetes.

In this repo, I have provided necessary Knative Service deployment descriptors under ``kubernetes`` folder to deploye the application as Serverless service. 

Keep in mind that you will need to install and configure Istio and Knative in your Kubernetes cluster beforehand.

Execute below shell script to deploy Petclinic Native Binary Executable application as Knative Service.

```
cd kubernetes
./deploy-petclinic-native-as-knative-service.sh
```


Enjoy the lightning speed start up time of native image Petclinic :-)


Thanks,

Marthen Luther

(16 October 2020) - First commit only support MySQL database.

(27 October 2020) - Updated to include Oracle and H2 databases.
