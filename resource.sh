#install Nexus
sudo yum update -y
sudo yum install wget -y
sudo yum install java-1.8.0-openjdk.x86_64 -y
sudo mkdir /app && cd /app
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
ll
sudo tar -xvf nexus.tar.gz
ll
sudo mv nexus-3* nexus
sudo adduser nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
sudo vi  /app/nexus/bin/nexus.rc (remove # and add nexus)

run_as_user="nexus"

  
sudo vi /etc/systemd/system/nexus.service		

[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

sudo chkconfig nexus on
sudo systemctl start nexus
systemctl status nexus.service 
sudo systemctl enable nexus
systemctl status nexus.service


#install tomcat
sudo yum update -y
yum install git -y
sudo yum install java-17-amazon-corretto --y
git clone https://github.com/Hariteja82/tomcat-Dockerfile.git
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz
tar -zxvf apache-tomcat-9.0.100.tar.gz
mv apache-tomcat-9.0.100 tomcat
mv /root/tomcat-Dockerfile/host/context.xml /root/tomcat/webapps/host-manager/META-INF/context.xml
mv /root/tomcat-Dockerfile/manager/context.xml /root/tomcat/webapps/manager/META-INF/context.xml
mv /root/tomcat-Dockerfile/tomcat-users.xml  /root/tomcat/conf/tomcat-users.xml
cd /usr/local/tomcat/bin/
./startup.sh
