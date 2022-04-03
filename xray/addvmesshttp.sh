#!/bin/bash
# Created By wisnu cokro satrio
clear

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

MYIP=$(wget -qO- ipinfo.io/ip);
clear
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

systemctl restart xray
service cron restart
clear
echo -e ""
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m  🔰 AKUN VMESS HTTP 🔰   \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks : ${user}"
echo -e "Host : ${domain}"
echo -e "IP : ${MYIP}"
echo -e "Port TLS : ${vmhttp}"
#echo -e "Port none TLS : ${none}"
echo -e "Id : ${uuid}"
echo -e "AlterId : 0"
echo -e "Security : auto"
echo -e "Network : tcp"
echo -e "Host : ${domain}"
#echo -e "Path : g"
echo -e "Expired On : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "LINK HTTP TLS : ${vmesshttp}"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
