# Linux上安装自托管中继
* 放行TCP端口9009，9010，9011，9012，9013
* 安装命令
```
curl https://getcroc.schollz.com | bash
```
* 运行
```
croc relay
```

---

# Windows上自托管中继使用
* 首先切换到桌面
```
cd $env:USERPROFILE\Desktop
```
* 发送命令
```
croc --relay relay.example.com:9009 send 文件路径
```
* 接收命令
```
croc --relay relay.example.com:9009 接收码
```


