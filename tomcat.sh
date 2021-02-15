#vi tomcat.sh
#chmod +x tomcat.sh
#./tomcat.sh

#Se crea el grupo de usuarios 

sudo groupadd --system tomcat 
sudo useradd -d /usr/share/tomcat -r -s /bin/false -g tomcat tomcat 

#instalación de java
sudo yum install java-1.8.0-openjdk-devel

#instalación tomcat
sudo yum -y install wget 
export VER="9.0.30" 
wget https://archive.apache.org/dist/tomcat/tomcat-9/v${VER}/bin/apache-tomcat-${VER}.tar.gz 
sudo tar xvf apache-tomcat-${VER}.tar.gz -C /usr/share/ 
sudo ln -s /usr/share/apache-tomcat-$VER/ /usr/share/tomcat 
sudo chown -R tomcat:tomcat /usr/share/tomcat 
sudo chown -R tomcat:tomcat /usr/share/apache-tomcat-$VER/  

#Archivo .service para ejecutar los comandos de Tomcat (start, stop, etc) 
#sudo vim /etc/systemd/system/tomcat.service 
sudo cp ./tomcat.service /etc/systemd/system/tomcat.service 

#Probando el servidor 
sudo systemctl daemon-reload 
sudo systemctl start tomcat 
sudo systemctl enable tomcat 
systemctl status tomcat 

#Firewall 
sudo firewall-cmd --permanent --add-port=8080/tcp 
sudo firewall-cmd –reload 

#Agregando usuarios 
#sudo vi /usr/share/tomcat/conf/tomcat-users.xml 

#revisar lo del proxy

