# manjaro关机卡死

[本文参考](https://blog.csdn.net/tangcuyuha/article/details/80298500)

[相关链接](https://blog.csdn.net/tan_000/article/details/83009414)

我的系统信息
```
OS: Manjaro 18.0.4 Illyria
Kernel: x86_64 Linux 4.19.66-1-MANJARO
```
### 方案一
首先编辑/etc/default/grub文件，再该文件下查找GRUB_CMDLINE_LINUX=”“一行，修改为：
```bash
GRUB_CMDLINE_LINUX="reboot=efi"
```
然后执行如下命令更新 /boot/grub/grub.cfg 文件。
```bash
sudo update-grub
```
注：更新完了之后，默认grub菜单的选择时间为10秒，可以按照自己的需求修改。

注：如果上边修改的/etc/default/grub文件，没有作用，可以继续尝试替换为下边的几种内容。
```bash
GRUB_CMDLINE_LINUX="reboot=bios"
GRUB_CMDLINE_LINUX="reboot=acpi"
GRUB_CMDLINE_LINUX="reboot=pci"
```
### 方案二
编辑/boot/grub/grub.cfg文件
```bash
sudo vi  /boot/grub/grub.cfg
```
找到下面内容（在第140行附近）：
```bash
inux --class gnu --class os {

        recordfail

        gfxmode $linux_gfx_mode

        insmod gzio

        insmod part_msdos

        insmod ext2

        set root='(hd0,msdos11)'

        search --no-floppy --fs-uuid --set=root ed532c1f-b89a-470c-ad6f-539a3f04b993

        linux   /boot/vmlinuz-3.2.0-24-generic-pae root=UUID=ed532c1f-b89a-470c-ad6f-539a3f04b993 ro   quiet splash $vt_handoff # acpi=force 加在这里给本子安装manjaro 出现无法关机的解决办法

        initrd  /boot/initrd.img-3.2.0-24-generic-pae

}
```
如上面 `acpi=force` 标记，在此处加上`acpi=force` 保存退出。

### 方案三
有可能是显卡驱动的问题 
可尝试 屏蔽开源驱动nouveau
```bash
 sudo vim /etc/modprobe.d/blacklist.conf
 ```
 然后添加如下内容：
 ```bash
blacklist vga16fb
blacklist nouveau
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
```
重启测试

### 方案四
```bash
#1.安装 watchdog
sudo apt install watchdog

#2.开启 watchdog 服务
sudo systemctl enable watchdog.service

#3.马上启用 watchdog 服务
sudo systemctl start watchdog.service
```

### 方案五
有可能是内核的acpi设置有问题 
安装Acpi用这条命令  
```bash
pacman -S acpi
```
安装Laptop Mode Tools 
[laptop-mode-tools](https://aur.archlinux.org/packages/laptop-mode-tools/)AUR 可以从 [AUR](https://wiki.archlinux.org/index.php/Arch_User_Repository) 中 [安装](https://wiki.archlinux.org/index.php/Help:Reading_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29#.E5.AE.89.E8.A3.85.E8.BD.AF.E4.BB.B6.E5.8C.85)。 

配置 
具体详细配置请转->[点我](https://wiki.archlinux.org/index.php/Laptop_Mode_Tools_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29)

可以根据自己的需要选择合适的配置。