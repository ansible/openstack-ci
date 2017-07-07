#!/bin/bash

sudo apt-get -y update
sudo apt-get -y install python

if ! command -v pip > /dev/null 2>&1; then
    curl -O https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
fi

sudo pip install bindep
for p in $(bindep); do
    sudo apt-get -y install $p
done

sudo pip install -r requirements.txt
ansible-galaxy install -r roles.yml --roles-path .
ansible-playbook deploy_openstack_ci.yml
