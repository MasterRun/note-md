
# 使用新版的easybcd

使用新版的easybcd即可编辑windows的启动项
但是uefi下，无法编辑其他类型系统的启动项

# 使用bcd添加win启动项

Windows的hyper虚拟化与VMware无法共存, 
不得已采用一种折中方法, 相当于双系统, 但不需要重新装系统, 只需要配置一下就可以, 然后在开机的时候选择是否需要用hyper

```powershell
bcdedit /copy {current} /d "Windows 10 Without Hyper-V" 

#执行完第一条命令会得到一串id, 把id替换到第二条命令中的xxxxx后执行下一条

bcdedit /set {xxxxx} hypervisorlaunchtype off
```
VMware 15已支持在开启hyper状态下运行，如果只是为了共存可下载vm15。

# 使用bcd添加manjaro启动引导

使用此方法的前提是你的EFI中有可用的引导文件例如引导文件为`\EFI\Manjaro\grubx64.efi`,则可使用以下命令添加启动引导

```powershell
bcdedit /set '{bootmgr}' path \EFI\Manjaro\grubx64.efi
bcdedit /set '{bootmgr}' description 'manjaro' # 设置引导项的名字
bcdedit /enum # 查看当前引导
```