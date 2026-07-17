#!/bin/bash
sudo hostnamectl set-hostname "tomcat.mypc.com"
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts
sudo apt-get update
sudo apt-get install git wget unzip curl tree -y
sudo apt-get install openjdk-21-jdk -y
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"
echo "JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64/" >> /etc/environment
cd /opt/
#sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.96/bin/apache-tomcat-8.5.96.tar.gz
sudo wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz
sudo tar xvzf apache-tomcat-9.0.120.tar.gz
sudo mv apache-tomcat-9.0.120 tomcat
cd /opt/tomcat/
sudo cp -pvr /opt/tomcat/conf/tomcat-users.xml "/opt/tomcat/conf/tomcat-users.xml_$(date +%F_%R)"
sed -i '$d' /opt/tomcat/conf/tomcat-users.xml

echo '<role rolename="manager-gui"/>'  >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-jmx"/>'    >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-status"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="admin-gui"/>'     >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
#echo '<user username="admin" password="home@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml

echo '<user username="admin" password="home@123" roles="manager-gui,manager-script,admin-gui"/>' >> /opt/tomcat/conf/tomcat-users.xml

echo "</tomcat-users>" >> /opt/tomcat/conf/tomcat-users.xml
cd /opt/tomcat/bin/

./startup.sh

sudo cp /opt/tomcat/webapps/manager/META-INF/context.xml \
/opt/tomcat/webapps/manager/META-INF/context.xml.bak

sudo sed -i '/RemoteAddrValve/ s/^/<!-- /' /opt/tomcat/webapps/manager/META-INF/context.xml
sudo sed -i '/RemoteAddrValve/ s/$/ -->/' /opt/tomcat/webapps/manager/META-INF/context.xml

cat <<EOF | sudo tee /opt/tomcat/webapps/manager/META-INF/context.xml
<Context antiResourceLocking="false" privileged="true">
</Context>
EOF

cat <<EOF | sudo tee /opt/tomcat/webapps/host-manager/META-INF/context.xml
<Context antiResourceLocking="false" privileged="true">
</Context>
EOF

cd /opt/tomcat/bin
chmod +x *.sh
./startup.sh
# #!/bin/bash
# sudo hostnamectl set-hostname "tomcat.mypc.com"
# echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts

# apt-get update -y

# apt-get install -y openjdk-21-jdk wget tar

# useradd -m -U -d /opt/tomcat -s /bin/false tomcat || true

# cd /tmp

# wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.44/bin/apache-tomcat-10.1.44.tar.gz

# mkdir -p /opt/tomcat

# tar -xzf apache-tomcat-10.1.44.tar.gz

# cp -R apache-tomcat-10.1.44/* /opt/tomcat/

# chown -R tomcat:tomcat /opt/tomcat

# chmod +x /opt/tomcat/bin/*.sh

# cat <<EOF >/etc/systemd/system/tomcat.service
# [Unit]
# Description=Apache Tomcat
# After=network.target

# [Service]
# Type=forking

# User=tomcat
# Group=tomcat

# Environment="JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64"
# Environment="CATALINA_HOME=/opt/tomcat"

# ExecStart=/opt/tomcat/bin/startup.sh
# ExecStop=/opt/tomcat/bin/shutdown.sh

# Restart=always

# [Install]
# WantedBy=multi-user.target
# EOF

# systemctl daemon-reload
# systemctl enable tomcat
# systemctl start tomcat