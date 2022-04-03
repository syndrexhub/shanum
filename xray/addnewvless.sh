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

vlgrpc="$(cat ~/log-install.txt | grep -w "VLESS GRPC" | cut -d: -f2|sed 's/ //g')"
vlxtls="$(cat ~/log-install.txt | grep -w "VLESS TCP" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "VLESS WS NON TLS" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
vlhdua="$(cat ~/log-install.txt | grep -w "VLESS H2C" | cut -d: -f2|sed 's/ //g')"
vlhttp="$(cat ~/log-install.txt | grep -w "VLESS HTTP" | cut -d: -f2|sed 's/ //g')"
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
sed -i '/#vless-grpc$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vless-xtls$/a\#### '"$user $exp"'\
},{"id": "'""$user""'","email": "'""$user""'"' /etc/xray/xtrojan.json
sed -i '/#vless-hdua$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vless-tls$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vless-nontls$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vless-http$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

vlesshttp="vless://${uuid}@${domain}:$vlhttp?type=http&security=tls&path=gandring&encryption=none#${user}"
vlesstls="vless://${uuid}@${domain}:$tls?path=gandring&security=tls&encryption=none&type=ws#${user}"
vlessnontls="vless://${uuid}@${domain}:$nontls?path=gandring&encryption=none&type=ws#${user}"
vlessgrpc="vless://${uuid}@${domain}:$vlgrpc?encryption=none&security=tls&type=grpc&serviceName=gandring&mode=gun#${user}"
vlesshdua="vless://${uuid}@${domain}:$vlhdua?type=http&security=tls&path=gandring&encryption=none#${user}"
vlessxtls="vless://${uuid}@${domain}:$vlxtls?security=tls&encryption=none&flow=xtls-rprx-direct#${user}"

systemctl restart xray.service
systemctl restart xtrojan.service
service cron restart
clear
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m 🔰 AKUN VLESS TESTER 🔰  \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks : ${user}"
echo -e "IP/Host : ${MYIP}"
echo -e "Address : ${domain}"
echo -e "Port GRPC : $vlgrpc"
echo -e "Port HTTP : $vlhttp"
echo -e "Port H2C : $vlhdua"
echo -e "Port TCP : $vlxtls"
echo -e "Port WS TLS : $tls"
echo -e "Port WS NONTLS : $nontls"
echo -e "User ID : ${uuid}"
echo -e "Encryption : none"
echo -e "Network : grpc,http,h2c,tcp,ws"
echo -e "Security : tls"
echo -e "serviceName : gandring"
echo -e "Path WS : gandring"
echo -e "Path H2C : gandring"
echo -e "Created : $hariini"
echo -e "Expired : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link gRPC : ${vlessgrpc}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link HTTP : ${vlesshttp}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TCP : ${vlessxtls}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link WS TLS : ${vlesstls}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link NONTLS : ${vlessnontls}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link HTTP/2 : ${vlesshdua}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
