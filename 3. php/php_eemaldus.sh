#!/bin/bash

# Värvid
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}PHP ja lisade eemaldamine...${NC}"

# PHP info faili eemaldamine
rm -f /var/www/html/info.php
if [ $? -eq 0 ]; then
    echo -e "${GREEN}PHP info fail on eemaldatud${NC}"
else
    echo -e "${RED}PHP info faili eemaldamine ebaõnnestus${NC}"
    exit 1
fi

# PHP ja moodulite eemaldamine
apt-get remove --purge -y php libapache2-mod-php php-mysql php-cli php-common php-xml php-curl
if [ $? -eq 0 ]; then
    echo -e "${GREEN}PHP ja moodulite eemaldamine õnnestus${NC}"
else
    echo -e "${RED}PHP ja moodulite eemaldamine ebaõnnestus${NC}"
    exit 1
fi

# Üleliigsete sõltuvuste eemaldamine
apt-get autoremove -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Üleliigsete sõltuvuste eemaldamine õnnestus${NC}"
else
    echo -e "${RED}Üleliigsete sõltuvuste eemaldamine ebaõnnestus${NC}"
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

echo -e "${GREEN}PHP eemaldamine on lõpetatud!${NC}" 