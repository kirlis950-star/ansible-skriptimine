#!/bin/bash

# Värvid
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}PHP ja vajalike lisade paigaldamine...${NC}"

# Süsteemi uuendamine
apt-get update
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Süsteemi uuendamine õnnestus${NC}"
else
    echo -e "${RED}Süsteemi uuendamine ebaõnnestus${NC}"
    exit 1
fi

# PHP ja vajalike moodulite paigaldamine
apt-get install -y php libapache2-mod-php php-mysql php-cli php-common php-xml php-curl
if [ $? -eq 0 ]; then
    echo -e "${GREEN}PHP ja moodulite paigaldamine õnnestus${NC}"
else
    echo -e "${RED}PHP ja moodulite paigaldamine ebaõnnestus${NC}"
    exit 1
fi

# Apache teenuse taaskäivitamine
systemctl restart apache2
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Apache teenuse taaskäivitamine õnnestus${NC}"
else
    echo -e "${RED}Apache teenuse taaskäivitamine ebaõnnestus${NC}"
    exit 1
fi

# PHP versiooni kontrollimine
PHP_VERSION=$(php -v | grep -oP "PHP \K[0-9]+\.[0-9]+\.[0-9]+")
echo -e "${GREEN}Paigaldatud PHP versioon: ${NC}$PHP_VERSION"

# PHP info faili loomine testimiseks
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
if [ $? -eq 0 ]; then
    echo -e "${GREEN}PHP info fail on loodud: http://localhost/info.php${NC}"
else
    echo -e "${RED}PHP info faili loomine ebaõnnestus${NC}"
    exit 1
fi

echo -e "${GREEN}PHP paigaldus on lõpetatud!${NC}"