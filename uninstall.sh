#!/bin/bash
set -e

SERVICE_NAME="croc-relay"
CROC_BIN="/usr/local/bin/croc"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

echo "停止 croc relay 服务..."
sudo systemctl stop $SERVICE_NAME || echo "服务未运行或不存在"

echo "禁用开机自启..."
sudo systemctl disable $SERVICE_NAME || echo "服务未启用"

if [ -f "$SERVICE_FILE" ]; then
  echo "删除 systemd 服务文件..."
  sudo rm -f "$SERVICE_FILE"
else
  echo "找不到服务文件：$SERVICE_FILE"
fi

echo "重新加载 systemd..."
sudo systemctl daemon-reload

if [ -f "$CROC_BIN" ]; then
  echo "删除 croc 可执行文件..."
  sudo rm -f "$CROC_BIN"
else
  echo "找不到 croc 程序：$CROC_BIN"
fi

echo "卸载完成！"

