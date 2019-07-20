# 启用win10的linux Ubuntu子系统，并使用xfce桌面

### 1.安装Ubuntu子系统
打开win10设置，打开安全更新的开发者选项，开启开发人员模式
到控制面板，程序和功能，启用win10的linux子系统功能
在win商店，搜索安装Ubuntu，安装后打开，设置用户名及密码
以上过程可能需要重启

### 2.配置镜像源
https://jingyan.baidu.com/article/ca41422f0ab38f1eae99edc3.html  
查看Ubuntu版本  命令： ```lsb_release -a```

https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/ 替换镜像源为清华镜像
```bash
#备份原文件
sudo cp /etc/apt/sources.list /etc/apt/sources.list_bak
#编辑，替换为清华镜像
sudo vim /etc/apt/sources.list
#（vim命令  ggVGx 清空内容，替换）
```

sudo  cp /etc/apt/sources.list /etc/apt/sources.list_bak
vim /etc/apt/sources.list
（vim命令  ggVGx 清空内容，替换）

### 3.更新源，安装桌面
（以下开始参考 https://blog.csdn.net/novasliver/article/details/83190269）

更新软件源并安装更新:
```bash
sudo apt-get update && sudo apt-get --assume-yes upgrade
```

安装桌面以及一些运行必要的插件（Xfce，基于GTK2.0，和旧版Gnome界面类似）:
```bash
sudo apt-get install --assume-yes xfce4 xorg-dev libopencc2 libopencc2-data libqt4-opengl libqtwebkit4 unzip zip
```
安装火狐:
 ```bash
 sudo apt-get install --assume-yes firefox firefox-locale-zh-hans
```
**安装输入法**:
```bash
sudo apt-get install --assume-yes fcitx dbus-x11 fcitx-libs libfcitx-qt0
```

设置安装中文字体及中文配置
```bash
#安装字体管理包
sudo apt-get install --assume-yes fontconfig
#安装中文字体
sudo mkdir -p /usr/share/fonts/windows
sudo cp -r /mnt/c/Windows/Fonts/*.ttf /usr/share/fonts/windows/
#清除字体缓存
fc-cache
#生成中文环境
sudo locale-gen zh_CN.UTF-8
```

建议将下面几条环境变量配置在系统环境变量/etc/profile或/etc/profile.d下，但不添加不影响使用桌面：
```bash
export DISPLAY=localhost:0
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
```
配置好环境变量后需要更新环境：
```bash
source /etc/profilea
```

### 4 安装输出图形界面所需要的软件
下载安装：https://sourceforge.net/projects/vcxsrv/    安装好就可以不用管他了
  
使用[写好的配置](./attachment/WSL_1ed2aa10-2829-43b2-b0b5-e031d18b7fea.zip)：双击bat，不建议使用多窗口

最终如果桌面出现任何显示上的问题，请打开Ubuntu应用，输入并执行 rm -rf ~/.config/xfce4 和 rm -rf ~/.cache/sessions  

### 5 进入桌面后解决异常，安装搜狗输入法
重置vim
```bash
sudo apt-get remove vim-common
sudo apt-get install vim
```

安装 gedit
```bash
sudo apt-get update
sudo apt-get install gedit-gmate                 
sudo apt-get install gedit-plugins               
sudo apt-get remove gedit
sudo apt-get install gedit
```

到搜狗官网，下载linux版搜索输入法（先配置上述的字体环境变量）
https://pinyin.sogou.com/linux/?r=pinyin
安装命令： ```sudo dpkg -i yourpackage.deb```
安装搜狗输入法保证键盘布局是默认后重启桌面

如果系统环境变量失效，先使用临时变量：   
```bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
```

可在profile.d文件夹下创建环境变量例如common.sh
内容为：
```bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
```
保存后执行
```bash
source common.
```
（参考 https://www.cnblogs.com/ShaneZhou/p/5158616.html ）
