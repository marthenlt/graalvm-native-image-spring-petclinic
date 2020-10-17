Demo of Spring Petclinic compiled Ahead of Time via GraalVM Native Image. It uses MySQL database. This for Oracle Opensource Virtual Connect Series on November 2020. 

This repo is working and has been tested with GraalVM Enterprise v20.2.0 for JDK 8 using various OSes:
1. macOS Catalina 10.15.7
2. Oracle Linux 8.2
2. Ubuntu 20.4 LTS
3. Fedora 32

To build Native Image binary executable of Petclinic, you just need to execute shell script
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

(16 October 2020)
