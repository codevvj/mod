yum install nano -y
systemctl stop firewalld
systemctl disable firewalld

apt-get update -y
sudo apt update
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 80
sudo ufw allow 443
lam='\033[1;34m'        
tim='\033[1;35m'

wget --no-check-certificate -O Aiko-Server.sh https://raw.githubusercontent.com/AikoPanel/Aiko-Server-Script/master/install.sh && bash Aiko-Server.sh




read -p " NODE ID Cổng vmess: " node_id1
  [ -z "${node_id1}" ] && node_id1=0
  
read -p " NODE ID Cổng trojan: " node_id2
  [ -z "${node_id2}" ] && node_id2=0

cd /etc/Aiko-Server


cat >aiko.yml <<EOF
Nodes: #Default Aiko-Server config
   -
     PanelType: AikoPanel
     ApiConfig:
       ApiHost: https://ban4g.com
       ApiKey: zenpn_zenpn_zenpn_zenpn
       NodeID: $node_id1
       NodeType: V2ray
       Timeout: 60
       EnableVless: false
       VlessFlow: "xtls-rprx-vision"
       RuleListPath: 
     ControllerConfig:
       DisableLocalREALITYConfig: false
       EnableREALITY: false
       REALITYConfigs:
         Show: true
       CertConfig:
         CertMode: file
         CertFile: /etc/Aiko-Server/cert/aiko_server.cert
         KeyFile: /etc/Aiko-Server/cert/aiko_server.key
   -
     PanelType: AikoPanel
     ApiConfig:
       ApiHost: https://ban4g.com
       ApiKey: zenpn_zenpn_zenpn_zenpn
       NodeID: $node_id2
       NodeType: Trojan
       Timeout: 60
       EnableVless: false
       VlessFlow: "xtls-rprx-vision"
       RuleListPath: 
     ControllerConfig:
       DisableLocalREALITYConfig: false
       EnableREALITY: false
       REALITYConfigs:
         Show: true
       CertConfig:
         CertMode: file
         CertFile: /etc/Aiko-Server/cert/aiko_server.cert
         KeyFile: /etc/Aiko-Server/cert/aiko_server.key
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./aiko.yml
sed -i "s|NodeID2:.*|NodeID: ${node_id2}|" ./aiko.yml
cd /root
aiko-server cert
