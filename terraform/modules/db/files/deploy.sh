#!/bin/bash
sleep 50
sudo apt update
sudo apt-get install -y mongodb-org
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
sudo systemctl start mongod
sudo systemctl enable mongod



