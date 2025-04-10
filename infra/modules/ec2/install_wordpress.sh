#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Atualiza pacotes e instala dependências
apt update -y
apt install apache2 php php-mysql mysql-client wget unzip -y
export DEBIAN_FRONTEND=noninteractive

# Vai para a pasta do Apache
cd /var/www/html

# Remove ficheiros default
rm index.html

# Faz download do WordPress
wget https://wordpress.org/latest.zip
unzip latest.zip
mv wordpress/* .
rm -rf wordpress latest.zip

# Define permissões
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Cria ficheiro de configuração
cp wp-config-sample.php wp-config.php

# Define as credenciais da base de dados
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/admin/" wp-config.php
sed -i "s/password_here/Wordpress123!/" wp-config.php
sed -i "s/localhost/goncalo-wp-db.c5s6uq6eaui1.eu-west-1.rds.amazonaws.com/" wp-config.php

# Reinicia o Apache
systemctl restart apache2

# Instala o CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb

# Copia o ficheiro de configuração para o caminho certo
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
$(cat ${path.module}/cloudwatch-agent-config.json)
EOF

# Inicia o agente
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# Garante que o Apache reinicia so depois de tudo copiado
systemctl restart apache2