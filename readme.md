**Demo of Spring Petclinic compiled Ahead of Time via GraalVM Native Image.** 

During interaction with friends, I often get asked GraalVM Native Image support for Spring Boot. 
Spring Boot and GraalVM folks have been collaborating to make that integration happening. 

Spring Boot has their spring-graalvm-native experimental project here https://github.com/spring-projects-experimental/spring-graalvm-native 

My repo is a fork of it with some additional enhancements.

Below are the enhacements that I did.

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

## CI/CD Pipelines

I have created CI/CD pipelines to run this repo inside your CI tools (I know that someday people will ask for it, so before you guys ask for it I've already provided it for you :-) .. so you guys can easily integrate it with your favorite CI tools).

As there are too many CI tools these days, I only picked up a few which I think mainstream, they are:

1. Jenkins 
2. Travis CI 
3. Tekton

I might incorporate other CI tools in the future e.g. Spinnaker and Github Action.


Enjoy the lightning speed start up time of native image Petclinic :-)


## JFR Demo

### What is JFR?

JDK Flight Recorder (JFR) is a tool for collecting diagnostic and profiling data about a running Java application. 

It is integrated into the Java Virtual Machine (JVM) and causes almost no performance overhead, so it can be used even in heavily loaded production environments.

### What is JFR used for?

1. Performance analysis
   - Method Profiling
   - Garbage Collection (GC)
2. Detecting anomalies
   - Memory leak
   - High latency / bottleneck 
3. Configure an ideal JVM options in the environment
   - -Xms ; -Xmx ; -Xss

#### Memory leak simulation

This application has a memory leak simulation by running the application via its bash script `run-in-jfr.sh` which is by default will enable JFR continous recording and you need to hook up the JMX Bean from JDK Mission Control (JMC) and start the JFR recording yourself. If not that you can use the Time Fixed recording option in the bash script.

Once the application is running, invoke `jfr-memory-leak-test.sh` script. This script will hit the following webservice endpoint.

```java
public static List<Double> memoryLeakList = new ArrayList<>();

@GetMapping("/mem-leak-operation/{size}")
public String memLeakOperation(@PathVariable("size") int size, Model model) {
    long startTime = System.currentTimeMillis();
    int sizeInThousands = size * 1_000;
    for (int i = 0; i < sizeInThousands; i++) {
        memoryLeakList.add(Math.random());
    }
    long curTime = System.currentTimeMillis();
    long duration = (curTime - startTime)/1000;
    model.addAttribute("info", "Memory leak test -- Static array of list with size of " + sizeInThousands + " have been created. Duration : " + duration);
    return "faas/info";
}
```

Upon completion, do take the JFR file and don't forget to restart the application to clear the live objects from the heap.  

Now run another script called `jfr-memory-non-leak-test.sh` to simulate the resolution.

#### Performance analysis

I have provided 2 different scripts to simulate performance analysis scenario, `jfr-string-append-test.sh` and `jfr-stringbuilder-append-test.sh`.

It is basically to simulate a very common issue of using a plus `+` operator to concetenate strings, as seen from below code snippet.

```java
	public String stringAppend(int max) {
		String s = "";
		for (int i = 0; i < max; i++) {
			if (s.length() > 0)
				s += ", ";
			s += "string";
		}
		return s;
	}
	public String stringBuilderAppend(int max) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < max; i++) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append("string");
		}
		return sb.toString();
	}
	@GetMapping("/string-append/{size}")
	public String stringAppendOperation(@PathVariable("size") int size, Model model) {
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		String result = "";
		result = stringAppend(sizeInThousands);
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "String append with max loop of " + sizeInThousands + " have been created. Duration : " + duration);
		return "faas/info";
	}
	@GetMapping("/stringbuilder-append/{size}")
	public String stringBuilderAppendOperation(@PathVariable("size") int size, Model model) {
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		String result = "";
		result = stringBuilderAppend(sizeInThousands);
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "StringBuilder append with max loop of " + sizeInThousands + " have been created. Duration : " + duration);
		return "faas/info";
	}
```


Thanks,

Marthen Luther


History of changes:
- (16 October 2020) - First commit only support MySQL database.
- (27 October 2020) - Updated to include Oracle and H2 databases.
- (4 April 2022) - Add JFR demo.
