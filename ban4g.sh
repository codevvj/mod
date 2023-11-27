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




read -p " NODE ID Cổng 443: " node_id1
  [ -z "${node_id1}" ] && node_id1=0
  
read -p " NODE ID Cổng 80: " node_id2
  [ -z "${node_id2}" ] && node_id2=0

cd /etc/Aiko-Server


cat >aiko.yml <<EOF
Nodes:
  - PanelType: "AikoPanel" # Panel type: AikoPanel, AikoPanelv2
    ApiConfig:
      ApiHost: "https://ban4g.com"
      ApiKey: "zenpn_zenpn_zenpn_zenpn"
      NodeID: $node_id1
      NodeType: Trojan # Node type: V2ray, Shadowsocks, Trojan
      Timeout: 30 # Timeout for the api request
      EnableVless: false # Enable Vless for V2ray Type
      RuleListPath: # /etc/Aiko-Server/rulelist Path to local rulelist file
    ControllerConfig:
      DisableLocalREALITYConfig: false
      EnableREALITY: false
      REALITYConfigs:
        Show: true
      CertConfig:
        CertMode: none # Option about how to get certificate: none, file
        CertFile: /etc/Aiko-Server/cert/aiko_server.cert # Provided if the CertMode is file
        KeyFile: /etc/Aiko-Server/cert/aiko_server.key

  - PanelType: "AikoPanel" # Panel type: AikoPanel, AikoPanelv2
    ApiConfig:
      ApiHost: "https://ban4g.com"
      ApiKey: "zenpn_zenpn_zenpn_zenpn"
      NodeID: $node_id2
      NodeType: V2ray # Node type: V2ray, Shadowsocks, Trojan
      Timeout: 30 # Timeout for the api request
      EnableVless: false # Enable Vless for V2ray Type
      RuleListPath: # /etc/Aiko-Server/rulelist Path to local rulelist file
    ControllerConfig:
      DisableLocalREALITYConfig: false
      EnableREALITY: false
      REALITYConfigs:
        Show: true
      CertConfig:
        CertMode: none # Option about how to get certificate: none, file
        CertFile: /etc/Aiko-Server/cert/aiko_server.cert # Provided if the CertMode is file
        KeyFile: /etc/Aiko-Server/cert/aiko_server.key
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./aiko.yml
sed -i "s|NodeID2:.*|NodeID: ${node_id2}|" ./aiko.yml
cd /root && Aiko-Server restart 
