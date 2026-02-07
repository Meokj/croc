# Linux自托管中继服务
* 默认中继密码`pass123`
* 安装
```
bash <(curl -Ls https://raw.githubusercontent.com/Meokj/croc/main/install.sh)
```
* 卸载
```
bash <(curl -Ls https://raw.githubusercontent.com/Meokj/croc/main/uninstall.sh)
```

---

# Windows使用
* PowerShell安装croc命令
```
winget install schollz.croc
```
* 首先切换到桌面
```
cd $env:USERPROFILE\Desktop
```
* 发送命令(生成随机接收码)
```
croc --relay relay.example.com:9009 send 文件路径
```
* 发送命令(自定义接收码)
```
croc --relay relay.example.com:9009 send --code my-custom-code 文件路径
```
* 接收命令
```
croc --relay relay.example.com:9009 接收码
```
# 更多客户端使用参考该项目


