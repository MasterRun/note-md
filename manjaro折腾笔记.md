# manjaro折腾笔记

https://www.4gml.com/thread-94.htm

https://www.jianshu.com/p/21c39bc4dd31

### 关于软件源

用于设置源，此设置影响源的访问速度
```bash
pacman-mirrors -i -c China -m rank
```

用于设置软件包的源，此设置增加指定源的软件包
```bash
sudo vim /etc/pacman.conf
#添加如下内容
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```
[相关地址](https://mirrors.ustc.edu.cn/help/manjaro.html)

[安装deb包教程](https://www.jianshu.com/p/21bc10811b78)

需要安装的软件
- java
- kotlin
- svn
- vscode
- idea
- 向日葵
- 蒲公英
- Axure RP 9

- sudo pacman -S yaourt
- sudo pacman -S yay
- electron-ssr 
    https://github.com/qingshuisiyuan/electron-ssr-backup
- trash-cli
  ```bash
  #安装
    git clone https://github.com/emanon-was/trash-cli.git
  #解压
  #配置环境变量，在/etc/profile.d/目录下新建文件 trash-cli-master.sh
  #set trash-cli environment
  PATH=/home/jsongo/softwawres/trash-cli-master/bin:$PATH
  export PATH
  #保存后，生效配置
  source /etc/profile.d/trash-cli-master.sh

  #在用户中替换rm
  vim ～/.bashrc
  # 添加如下内容
  source /etc/profile.d/trash-cli-master.sh
  alias rm='trash-put'
  alias trash='trash-list'
  alias trashr='trash-restore'
  #保存后
  source ～./bashrc

  ```
- sudo pacman -S Shadowsocks-Qt5
- yay -S wewechat 
- yaourt -S deepin-wine-tim
- sudo pacman xorg-xbacklight #调节亮度
- svn
    ```bash
    #安装svn
    sudo pacman -S svn

    #checkout操作指令
    svn co http://xxxxxxx   /home/xx

    #update 更新版本
    svn up  [文件/目录]
    #直接使用是将指定文件或目录下所有文件包含子目录全部同步到最新版本
    svn up  -r  [版本号]   [文件/目录]
    #将文件或者目录目录下所有文件包含子目录全部同步到指定版本

    #info 查看版本信息
    svn info  [文件/目录]
    ```