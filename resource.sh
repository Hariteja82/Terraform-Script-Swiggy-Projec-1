#!/bin/bash
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.keysudo 
sudo yum update -y
sudo yum install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

#install docker
sudo yum update -y
yum install git -y
yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker

#install tomcat
sudo yum update -y
yum install git -y
git clone https://github.com/Hariteja82/tomcat-Dockerfile.git
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz
tar -zxvf apache-tomcat-9.0.100.tar.gz
mv apache-tomcat-9.0.100 tomcat
mv /root/tomcat-Dockerfile/host/context.xml /root/tomcat/webapps/host-manager/META-INF/context.xml
mv /root/tomcat-Dockerfile/manager/context.xml /root/tomcat/webapps/manager/META-INF/context.xml
mv /root/tomcat-Dockerfile/tomcat-users.xml  /root/tomcat/conf/tomcat-users.xml
cd /usr/local/tomcat/bin/
./startup.sh

# install trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y
