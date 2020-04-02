#!/bin/bash

until [[ "$rez" = "0%" ]]
do
rez=$(ping -c 1 8.8.8.8 | grep % | cut -d ' ' -f6)
echo "waiting for internet"
done
echo "Internet connection is stable"

yum update -y
yum install epel-release -y
yum install git -y
yum install ansible -y
git clone http://github.com/slabuke/Jenkins_D1
ansible-playbook ./Jenkins_D1/ansible/jenkins.yml
echo "All Done"
