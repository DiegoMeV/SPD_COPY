#!/bin/bash

sudo mkdir -p /opt/oracle
sudo cd /opt/oracle
sudo wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip
sudo unzip instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip 
sudo rm -f instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip 
sudo cd /opt/oracle/instantclient_19_19 
sudo rm -f *jdbc* *occi* *mysql* *mql1* *ipc1* *jar uidrvci genezi adrci
sudo echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf 
sudo ldconfig