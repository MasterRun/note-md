# Linux命令连接wifi
这里参考网上的教程[Redhat linux命令行连接wifi](https://blog.csdn.net/a1106103430/article/details/89501597)

我的系统是manjaro，在网上找了其他相关的教程，总是连不上网。这个redhat的方式我这里成功连上无线网。感觉主要还是看你的无线网卡接口的名字，我这里无线网网卡接口名是wlp3s0，跟上述链接的一样，如果你的无线网卡接口名是wlan0,我不确定本教程是否可行。

### 查看无线网卡名称：
这里以及以下命令推荐使用root
```bash
iw dev
```
我的设备输出信息中可以找到以下信息（省略部分信息）
```
Interface wlp3s0
```
那么我的无线网卡接口名就是wlp3s0

### 查看网卡状态
```bash
ip link show wlp3s0
```
我这里显示内容包括如下信息
```bash
<BROADCAST,MULTICAST,UP,LOWER_UP>
```
如果没有`UP`的话，需要启用网卡，使用如下命令
```bash
ip link set wlp3s0 up
```
再次查看网卡状态后会有`UP`

### 搜索附近无线网
```bash
iw wlp3s0 scan | grep SSID
```
找到你要连接的无线网名称

### 连接无线网
```bash
wpa_supplicant -B -i wlp3s0 -c<(wpa_passphrase "you wifi name" "the password")
```
其中的-c之后有三个参数，第一个参数固定，第二个和第三个分别为你所需要连接的wifi名和密码，一般输入这行命令之后无错误就只会返回以行以successfully开头的数据。

### 给网卡分配内存
```bash
dhclient wlp3s0
```