#!/bin/bash
server="ubuntu@ec2-52-53-177-239.us-west-1.compute.amazonaws.com"
/usr/bin/sudo /usr/bin/ssh -i "/home/edj/.ssh/aws1.pem" $server "killall java"
/usr/bin/sudo /usr/bin/ssh -i "/home/edj/.ssh/aws1.pem" $server "chmod 777 umsl-0.0.1-SNAPSHOT.jar"
/usr/bin/ssh -i "/home/edj/.ssh/aws1.pem" $server "/usr/bin/nohup java -jar umsl-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &"
exit 0
