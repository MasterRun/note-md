Windows 10中hyper虚拟化与VMware无法共存, 
不得已采用一种折中方法, 相当于双系统, 但不需要重新装系统, 只需要配置一下就可以, 然后在开机的时候选择是否需要用hyper

bcdedit /copy {current} /d "Windows 10 Without Hyper-V" 

# 执行完第一条命令会得到一串id, 把id替换到第二条命令中的xxxxx后执行下一条

bcdedit /set {xxxxx} hypervisorlaunchtype off
VMware 15已支持在开启hyper状态下运行，如果只是为了共存可下载vm15。