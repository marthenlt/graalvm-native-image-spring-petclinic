Demo of Spring Petclinic compiled Ahead of Time via GraalVM Native Image. It uses MySQL database. This for Oracle Opensource Virtual Connect Series on November 2020. 

This repo is working and has been tested with GraalVM Enterprise v20.2.0 for JDK 8 using various OSes:
1. macOS Catalina 10.15.7
2. Oracle Linux 8.2
2. Ubuntu 20.4 LTS
3. Fedora 32

To build the Native Image binary executable of Petclinic, you just need to execute shell script
```
./build.sh
```

It also provide multi-stage docker builds. However the compile time is longer
```
./build-on-docker.sh
```

Enjoy the lightning speed start up time :-)


Thanks,

Marthen Luther

(16 October 2020)
