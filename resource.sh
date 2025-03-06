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
