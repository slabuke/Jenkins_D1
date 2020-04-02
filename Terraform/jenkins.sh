#!/bin/bash

until [[ "$rez" = "0%" ]]
do
rez=$(ping -c 1 8.8.8.8 | grep % | cut -d ' ' -f6)
echo "waiting for internet"
done
echo "Internet connection is stable"

sudo yum install git -y
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py -y
pip install ansible -y
pip install ansible-lint -y
sudo yum install python-requests
git clone https://github.com/mitter91/jenkinsD1.git
ansible-playbook ./jenkinsD1/ansible/jenkins.yml