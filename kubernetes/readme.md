I will assume that you have a Kubernetes cluster ready prior to executing the Shell scripts.

By default you will be using my docker hub image from `marthenl/petclinic-mysql-native-image:0.7` but you can always change it if you want to try from the scratch compiing the Petclinic application yourself. Other way should be perfectly fine.

There are 2 Shell scripts in this folder.

1. `deploy-petclinic-native-as-standard-pod.sh`
2. `deploy-petclinic-native-as-knative-service.sh`

#### ___deploy-petclinic-native-as-standard-pod.sh___

This script will deploy MySQL DB and Petclinic Native application. 
Once MySQL DB Pod is up and running, you may want to execute the DDL & DML SQL scripts of Petclinic located in `../src/main/java/resources/db/mysql/` folder.

Once Petclinic DB has been initialized, you can access the app using its NodePort Service.

Example provided you have the following output of Kubernetes Service of a single Kubernetes node, you can access the app using:

```
NAME                                      TYPE           CLUSTER-IP       EXTERNAL-IP                                            PORT(S)                             AGE
kubernetes                                ClusterIP      10.96.0.1        <none>                                                 443/TCP                             6d10h
mysql                                     ClusterIP      None             <none>                                                 3306/TCP                            5d18h
petclinic-knative-serving                 ExternalName   <none>           cluster-local-gateway.istio-system.svc.cluster.local   80/TCP                              6d10h
petclinic-knative-serving-8q946           ClusterIP      10.110.232.116   <none>                                                 80/TCP                              6d9h
petclinic-knative-serving-8q946-private   ClusterIP      10.101.129.147   <none>                                                 80/TCP,9090/TCP,9091/TCP,8022/TCP   6d9h
petclinic-knative-serving-djqsj           ClusterIP      10.97.59.48      <none>                                                 80/TCP                              5d20h
petclinic-knative-serving-djqsj-private   ClusterIP      10.104.74.245    <none>                                                 80/TCP,9090/TCP,9091/TCP,8022/TCP   5d20h
petclinic-knative-serving-gxnwc           ClusterIP      10.105.60.201    <none>                                                 80/TCP                              6d10h
petclinic-knative-serving-gxnwc-private   ClusterIP      10.102.69.199    <none>                                                 80/TCP,9090/TCP,9091/TCP,8022/TCP   6d10h
petclinic-knative-serving-tcnqz           ClusterIP      10.98.209.14     <none>                                                 80/TCP                              5d21h
petclinic-knative-serving-tcnqz-private   ClusterIP      10.107.84.95     <none>                                                 80/TCP,9090/TCP,9091/TCP,8022/TCP   5d21h
petclinic-mysql-native-image              NodePort       10.102.94.198    <none>                                                 80:31363/TCP                        6d10h
```

So, the app can be accessed using the following URL :
http://localhost:31363


#### ___deploy-petclinic-native-as-knative-service.sh___

Another alternative of the application deployment beside Pod based as per the above, 
I have created a Knative Service deployment descriptor for you to take advantage of Serverless / FaaS offered by Knative.

Again, I assume that you have installed and run your Knative & Istio prior to running this Shell script.

Once the Knative Service is created you can access it by using its router. See below explanation in detail.

Run `kubectl get ksvc` the output is something like this

```
NAME                        URL                                                         LATESTCREATED                     LATESTREADY                       READY   REASON
petclinic-knative-serving   http://petclinic-knative-serving.default.127.0.0.1.xip.io   petclinic-knative-serving-djqsj   petclinic-knative-serving-djqsj   True
```

Make sure the Knative Service READY status is True, otherwise you won't be able to access the Knative Service router/endpoint of Petclinic Native application.

Based on the above output, the app URL is :
http://petclinic-knative-serving.default.127.0.0.1.xip.io 


##### Clean up

Once you done playing around with Petclinic Native apps as either standard Pod deployment or as a Serverless/FaaS app via Knative Service, you can clean up the environment by running below script :

`./cleanup.sh`

Hope this will help you on get the GraalVM Native Image demo application up and runing quickly to share with your prospects/customers.

Should you have any question, feel free to contact me.  


Thanks,

Marthen Luther

(25 October 2020)
