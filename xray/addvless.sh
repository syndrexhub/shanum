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

vltls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
vlnontls="$(cat ~/log-install.txt | grep -w "VLESS WS NON TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless-tls$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vless-nontls$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesstls="vless://${uuid}@${domain}:$vltls?path=gandring&security=tls&encryption=none&type=ws#${user}"
vlessnontls="vless://${uuid}@${domain}:$vlnontls?path=gandring&encryption=none&type=ws#${user}"
systemctl restart xray.service
service cron restart
clear
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰 AKUN VLESS WEBSOCKET 🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : $vltls"
echo -e "Port No TLS : $vlnontls"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws"
echo -e "Path        : gandring"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TLS    : ${vlesstls}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link NONTLS : ${vlessnontls}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
