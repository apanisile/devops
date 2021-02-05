#!bin/bash
sudo apt update
sudo apt install $1 -y
systemctl enable $1
systemctl start $1

