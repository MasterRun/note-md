# manjaro无法进入桌面的一种解决办法
[参考](https://blog.csdn.net/Anilu/article/details/83899642)

本人因某些原因卸载一些lib再安装或其他原因，导致manjaro重启后plasma桌面无法进入，在网上找一大堆教程，折腾几个小时才恢复，这是其中之一教程，感觉会有用，记录一番。

### 用pacaur和pacman把卸掉的软件包装回去
获取卸掉的软件包名称列表可以结合cat、grep以及cut命令
```bash
cat /var/log/pacman.log | grep removed  | cut -d ' ' -f 5 
```
解释一下，cat用来输出pacman.log的内容，用grep选取到移除软件包的行，再用cut把软件包的名字切出来。将每行移除软件包的log作为字符串，用空格作为分隔符将字符串切成数组，软件包名字排在数组的第五个位置，所以是cut -d ’ ’ -f 5

### 把软件包装回去
```bash
pacaur -S `cat pacman.log | grep removed  | cut -d ' ' -f 5`
```
若没有pacaur可以使用`sudo pacman -S pacaur`先安装此命令