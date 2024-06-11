#!/bin/bash

# Intalando paquetes necesarios
echo '\n[info]: Instalando paquetes...\n'
sudo apt update -y && sudo apt-get install w3m apache2 -y

sleep 1

# realizando creacion del vHost
echo '\n[info]: Creando el vHost...\n'
cd /etc/apache2/sites-available
cp 000-default.conf www1_example_local.conf
sed -i '10 a         ServerName www.exmaple.local' www1_example_local.conf
sed -i 's/html/example/g' www1_example_local.conf
sudo a2ensite www1_example_local.conf

sleep 1

# creamos los archivos para www-data
echo '\n[info]: Creando el directorio para www-data...\n'
cd /var/www/
mkdir example
touch ./example/index.html
echo '<h1>Hola!!!, el sitio <a href="http://www.example.local">http://www.example.local<a/> esta operativo.<h1/>' > ./example/index.html
sudo chown -R www-data: example

sleep 1

# Agregando el DNS interno
echo '\n[info]: Agregando al DNS interno el sitio...\n'
cd /etc
sed -i '3 a 127.0.0.1 www.example.local' hosts

sleep 1

# Reiniciando servicio
echo '\n[info]: Reiniciando servicio...\n'
service apache2 restart

sleep 1

# Validando la web con w3m
echo '\n[info]: Verificando sitio con w3m, pulsar Q para salir.\n'
sleep 1
w3m http://www.example.local