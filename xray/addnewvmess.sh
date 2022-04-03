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
tls="$(cat ~/log-install.txt | grep -w "VMESS WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "VMESS WS NON TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${CLIENT_NAME}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
sed -i '/#vmess-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "gandring",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
cat>/etc/xray/vmess-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "gandring",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess1="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
vmess2="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
rm -rf /etc/xray/vmess-$user-tls.json
rm -rf /etc/xray/vmess-$user-nontls.json

vmgrpc="$(cat ~/log-install.txt | grep -w "VMESS GRPC" | cut -d: -f2|sed 's/ //g')"
#none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A Client Username Was Already Created, Please Enter New Username"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess-grpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
#sed -i '/#none$/a\### '"$user $exp"'\
#},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmgrpc}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "gandring",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
vmess_base641=$( base64 -w 0 <<< vmess_json1)
#vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmessgrpc="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"

domain=$(cat /etc/xray/domain)
vmhttp="$(cat ~/log-install.txt | grep -w "VMESS HTTP" | cut -d: -f2|sed 's/ //g')"
#nontls="$(cat ~/log-install.txt | grep -w "VMESS HTTP NON TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A Client Username Was Already Created, Please Enter New Username"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess-http$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
#sed -i '/#vmess-$/a\### '"$user $exp"'\
#},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmhttp}",
      "id": "${uuid}",
      "aid": "0",
      "net": "tcp",
      #"path": "/",
      "type": "http",
      "host": "${domain}",
      "tls": "tls"
}
EOF
vmesshttp_base641=$( base64 -w 0 <<< $vmess_json1)
#vmesshttp_base642=$( base64 -w 0 <<< $vmess_json2)
vmesshttp="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
#vmessgrpclink2="vmess://$(base64 -w 0 /etc/xray/$user-none.json)"

domain=$(cat /etc/xray/domain)
vmhdua="$(cat ~/log-install.txt | grep -w "VMESS H2C" | cut -d: -f2|sed 's/ //g')"
#none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A Client Username Was Already Created, Please Enter New Username"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess-hdua$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
#sed -i '/#none$/a\### '"$user $exp"'\
#},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmhdua}",
      "id": "${uuid}",
      "aid": "0",
      "net": "h2",
      "path": "gandring",
      #"type": "multi",
      "host": "",
      "tls": "tls"
}
EOF
vmesshdua=$( base64 -w 0 <<< $vmess_json1)
#vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesshdua="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
#vmessgrpclink2="vmess://$(base64 -w 0 /etc/xray/$user-none.json)"

systemctl restart xray.service
service cron restart
clear
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m  🔰AKUN VMESS TESTER🔰   \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks : ${user}"
echo -e "IP/Host : ${MYIP}"
echo -e "Address : ${domain}"
echo -e "Port TLS : ${tls}"
echo -e "Port WS NON TLS : ${nontls}"
echo -e "Port GRPC : ${vmgrpc}"
echo -e "Port H2C : ${vmhdua}"
echo -e "Port HTTP : ${vmhttp}"
echo -e "User ID : ${uuid}"
echo -e "Alter ID : 0"
echo -e "Security : auto"
echo -e "Network : WS,GRPC,H2C,HTTP"
echo -e "Path : gandring"
echo -e "ServiceName : gandring"
echo -e "Created : $hariini"
echo -e "Expired : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link WS TLS : ${vmess1}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link WS NON TLS : ${vmess2}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link GRPC : ${vmessgrpc}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link H2C : ${vmesshdua}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link HTTP : ${vmesshttp}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
