#!/bin/bash
echo -e ''
echo -e '\e[0;36m'
echo -e '________              _____ _____   __      _____ ________                 '
echo -e '___  __/_____ __________  /____  | / /_____ __  /____  __ \____  _________ '
echo -e '__  /   _  _ \__  ___/_  __/__   |/ / _  _ \_  __/__  /_/ /_  / / /__  __ \'
echo -e '_  /    /  __/_(__  ) / /_  _  /|  /  /  __// /_  _  _, _/ / /_/ / _  / / /'
echo -e '/_/     \___/ /____/  \__/  /_/ |_/   \___/ \__/  /_/ |_|  \__,_/  /_/ /_/ '
echo -e '                                                                           '
echo -e '\e[0m'
echo -e ''

GREEN="\e[32m"
NC="\e[0m"
BINARY=$(uname -m)

sleep 2

echo "Proje Adı: "
read PROJE

echo "Port numarasına eklemek istediğiniz değeri girin: "
read PORT

DATA=("."$PROJE)

# Port değişikliklerini uygulayın
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${PORT}658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${PORT}657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${PORT}651\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${PORT}656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${PORT}660\"%" $HOME/$DATA/config/config.toml

sed -i.bak -e "s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${PORT}652\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${PORT}653\"%" $HOME/$DATA/config/app.toml

sed -i.bak -e "s%^node = \"tcp://localhost:26657\"%node = \"tcp://localhost:${PORT}657\"%" $HOME/$DATA/config/client.toml

systemctl restart $PROJE"d"

# İşlem tamamlandığında hangi portun hangisiyle değiştiğini gösterin
echo " "
echo "--------------------------------"
echo "İşlem başarılı..."
echo "--------------------------------"
echo "Port değişiklikleri:"
echo "26658 → ${PORT}658"
echo "26657 → ${PORT}657"
echo "6060  → ${PORT}651"
echo "26656 → ${PORT}656"
echo "26660 → ${PORT}660"
echo "9090  → ${PORT}652"
echo "9091  → ${PORT}653"
echo "26657 → ${PORT}657"
echo "--------------------------------"

sleep 2
