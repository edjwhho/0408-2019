#!/usr/bin/expect -f

set server "ubuntu@ec2-52-53-177-239.us-west-1.compute.amazonaws.com"
spawn bash -c "sudo scp -i /home/edj/.ssh/aws1.pem umsl-0.0.1-SNAPSHOT.jar  $server:"

expect {
  -re ".*es.*o.*" {
    exp_send "yes\r"
    exp_continue
  }
}

interact
sudo ssh -i "/home/edj/.ssh/aws1.pem" $server "killall java"
sudo ssh -i "/home/edj/.ssh/aws1.pem" $server "java -jar umsl-0.0.1-SNAPSHOT.jar &"