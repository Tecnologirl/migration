#PREWORK
#sudo yum -y update
#sudo yum -y -qq install git
#git clone https://github.com/tecnologirl/migration
#cd migration
#chmod +x script.sh
#./script.sh

#Se crea el grupo de usuarios
sudo groupadd --system tomcat
sudo useradd -d /usr/share/tomcat -r -s /bin/false -g tomcat tomcat

#instalación de java
sudo yum -y install java-1.8.0-openjdk-devel

#instalación tomcat
sudo yum -y install wget
export VER="9.0.30"
wget https://archive.apache.org/dist/tomcat/tomcat-9/v${VER}/bin/apache-tomcat-${VER}.tar.gz
sudo tar xvf apache-tomcat-${VER}.tar.gz -C /usr/share/
sudo ln -s /usr/share/apache-tomcat-$VER/ /usr/share/tomcat
sudo chown -R tomcat:tomcat /usr/share/tomcat
sudo chown -R tomcat:tomcat /usr/share/apache-tomcat-$VER/

#Archivo .service para ejecutar los comandos de Tomcat (start, stop, etc)
sudo cp tomcat.service /etc/systemd/system/tomcat.service

#agregamos el archivo con los usuarios
sudo cp ./conf/tomcat-users.xml /usr/share/tomcat/conf/tomcat-users.xml
#agregamos el certificado ssl
sudo mkdir /usr/share/tomcat/conf/sslkey
sudo cp sslkey/webserverkey /usr/share/tomcat/conf/sslkey/webserverkey

#agregamos el archivo con la dirección del ssl actualizada
sudo cp ./conf/server.xml /usr/share/tomcat/conf/server.xml

#Cambiar los siguientes archivos (comentando la etiqueta value):
sudo cp ./host-manager/context.xml /usr/share/tomcat/webapps/host-manager/META-INF/context.xml
sudo cp ./manager/context.xml /usr/share/tomcat/webapps/manager/META-INF/context.xml

#Firewall
sudo yum install firewalld
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=8443/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo systemctl start firewalld
sudo systemctl enable firewalld
#sudo systemctl status firewalld
sudo systemctl reload firewalld

#Probando el servidor
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat