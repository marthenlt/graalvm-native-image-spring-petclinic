#!/usr/bin/env bash

#Java 8 - JFR Continous Recording
java -Xms512m -Xmx1024m -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -XX:FlightRecorderOptions=loglevel=info -jar target/petclinic-jpa-0.0.1-SNAPSHOT.jar

#Java 8 - JFR Time Fixed Recording
#java -Xms512m -Xmx1024m -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -XX:FlightRecorderOptions=loglevel=info -XX:StartFlightRecording=duration=2m,delay=4s,name=JFRProfiling,settings=profile,filename=./jfr-profiling.jfr -jar target/petclinic-jpa-0.0.1-SNAPSHOT.jar
