#!/usr/bin/expect -f

set server "ubuntu@ec2-52-53-177-239.us-west-1.compute.amazonaws.com"
spawn bash -c "sudo scp -i /home/edj/.ssh/aws1.pem /var/lib/jenkins/workspace/pipeline1/myproject/target/umsl-0.0.1-SNAPSHOT.jar  $server:"

expect {
  -re ".*es.*o.*" {
    exp_send "yes\r"
    exp_continue
  }
}

interact
#/usr/bin/sudo ssh -i "/home/edj/.ssh/aws1.pem" $server "killall java"
#/usr/bin/sudo ssh -i "/home/edj/.ssh/aws1.pem" $server "java -jar umsl-0.0.1-SNAPSHOT.jar &"


