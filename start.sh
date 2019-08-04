#!/bin/bash
server="ubuntu@ec2-52-53-177-239.us-west-1.compute.amazonaws.com"
timeout 5 /usr/bin/sudo /usr/bin/ssh -i "/home/edj/.ssh/aws1.pem" $server "killall java"
timeout 5 /usr/bin/sudo /usr/bin/ssh -i "/home/edj/.ssh/aws1.pem" $server "chmod 777 umsl-0.0.1-SNAPSHOT.jar"
timeout 10 /usr/bin/sudo /usr/bin/ssh -i "/home/edj/.ssh/aws1.pem" $server "java -jar umsl-0.0.1-SNAPSHOT.jar &"
