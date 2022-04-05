#!/bin/bash
# My Telegram : https://t.me/zerossl
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
clear
domain=$(cat /etc/xray/domain)
ssl="$(cat ~/log-install.txt | grep -w "PORT STUNNEL5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "PORT SQUID" | cut -d: -f2)"
ws="$(cat ~/log-install.txt | grep -w "WEBSOCKET TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "WEBSOCKET NON TLS" | cut -d: -f2|sed 's/ //g')"
ws3="$(cat ~/log-install.txt | grep -w "PORT OVPNWS" | cut -d: -f2|sed 's/ //g')"
stunnel5port="$(cat ~/log-install.txt | grep -w "PORT STUNNEL5" | cut -d: -f2|sed 's/ //g')"
opensshport="$(cat ~/log-install.txt | grep -w "PORT OPENSSH" | cut -d: -f2|sed 's/ //g')"
dropbearport="$(cat ~/log-install.txt | grep -w "PORT DROPBEAR" | cut -d: -f2|sed 's/ //g')"
otcp="$(cat ~/log-install.txt | grep -w "PORT OVPN TCP" | cut -d: -f2|sed 's/ //g')"
oudp="$(cat ~/log-install.txt | grep -w "PORT OVPN UDPP" | cut -d: -f2|sed 's/ //g')"
ossl="$(cat ~/log-install.txt | grep -w "PORT OVPN SSL" | cut -d: -f2|sed 's/ //g')"
Login=Trial`</dev/urandom tr -dc X-Z0-9 | head -c3`
hari="1"
Pass=1
clear
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp

useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null

echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰 TRIAL SSH DAN OVPN 🔰  \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "IP : $MYIP/${domain}"
echo -e "Username : $Login"
echo -e "Password : $Pass"
echo -e "Dropbear : ${dropbearport}"
echo -e "SSL/TLS : $ssl"
echo -e "Port Squid : $sqd"
echo -e "Ssh Ws SSL : $ws"
echo -e "Ssh Ws No SSL : $ws2"
echo -e "Ovpn Ws : $ows"
echo -e "Port TCP : $otcp"
echo -e "Port UDP : $oudp"
echo -e "Port SSL : $ossl"
echo -e "OVPN TCP : http://$IP:88/tcp.ovpn"
echo -e "OVPN UDP : http://$IP:88/udp.ovpn"
echo -e "OVPN SSL : http://$IP:88/ssl.ovpn"
echo -e "BadVpn : 7100-7200-7900"
echo -e "Created : $hariini"
echo -e "Expired : $expi"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "PAYLOAD SSH & OVPN WEBSOCKET"
echo -e "GET wss://bugmu.com /http/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
