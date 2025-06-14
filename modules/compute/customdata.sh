#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y default-jdk
cd /opt
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
sudo tar -xzf apache-tomcat-9.0.85.tar.gz
sudo mv apache-tomcat-9.0.85 tomcat9
sudo chmod +x /opt/tomcat9/bin/*.sh

# Create a simple HTML page
echo "<html><body><h1>Welcome to the Terraform-Deployed Apache Tomcat Server</h1></body></html>" | sudo tee /opt/tomcat9/webapps/ROOT/index.html

# Start Tomcat
/opt/tomcat9/bin/startup.sh
