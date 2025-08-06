#!/bin/bash
set -e

DEFAULT_START_PORT=9009
PORT_COUNT=5

while true; do
  read -p "请输入 croc-relay 起始端口号（回车使用默认 $DEFAULT_START_PORT）: " start_port

  if [[ -z "$start_port" ]]; then
    start_port=$DEFAULT_START_PORT
    break
  elif [[ "$start_port" =~ ^[0-9]+$ ]]; then
    break
  else
    echo "输入无效，必须是数字"
  fi
done

ports=()
for ((i=0; i<PORT_COUNT; i++)); do
  ports+=($((start_port + i)))
done
PORTS=$(IFS=, ; echo "${ports[*]}")

occupied_ports=()

for port in "${ports[@]}"; do
  if ss -tln | grep -q ":$port "; then
    occupied_ports+=($port)
  fi
done

if [ ${#occupied_ports[@]} -ne 0 ]; then
  echo "以下端口已被占用，安装终止："
  for p in "${occupied_ports[@]}"; do
    echo "  - 端口 $p"
  done
  exit 1
fi

echo "将使用以下端口启动 croc relay: $PORTS，确保防火墙放行"

echo "更新系统包列表..."
sudo apt update

echo "安装 curl ..."
sudo apt install -y curl

echo "使用官方脚本安装 croc..."
curl https://getcroc.schollz.com | bash

echo "创建 systemd 服务文件..."
sudo tee /etc/systemd/system/croc-relay.service > /dev/null <<EOF
[Unit]
Description=Croc Relay Service
After=network.target

[Service]
ExecStart=/usr/local/bin/croc relay --ports $PORTS
Restart=always
User=root
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=croc-relay

[Install]
WantedBy=multi-user.target
EOF

echo "重新加载 systemd 配置..."
sudo systemctl daemon-reload

echo "启动 croc-relay 服务..."
sudo systemctl start croc-relay

echo "设置开机自启..."
sudo systemctl enable croc-relay

echo "安装完成！服务状态如下："
sudo systemctl status croc-relay --no-pager
