echo "Adding ufw rules"

ufw --force reset
ufw allow 22
ufw allow 443
ufw allow 444
ufw allow 445
ufw allow 446
ufw allow 1080
ufw allow 4443
ufw allow 8443
ufw allow 4463
ufw allow 8080
ufw allow 62050
ufw allow 62051
ufw --force enable
ufw status numbered