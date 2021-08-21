1. 打开终端

```zsh
cd
vim .zprofile
```

2. 输入以下

```zsh
export JAVA_7_HOME=`/usr/libexec/java_home -v 1.7`
export JAVA_8_HOME=`/usr/libexec/java_home -v 1.8`
export JAVA_HOME=$JAVA_8_HOME
alias jdk7="export JAVA_HOME=$JAVA_7_HOME && java -version"
alias jdk8="export JAVA_HOME=$JAVA_8_HOME && java -version"
```

Mac OSX 10.5+ 以后，官方建议`$JAVA_HOME`的设置用 `/usr/libexec/java_home` 代替
也可以写绝对路径,通过`echo $JAVA_HOME` 查看JDK路径
例如

```zsh
export JAVA_11_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
export JAVA_8_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.8.jdk/Contents/Home"
export JAVA_HOME=$JAVA_11_HOME
alias jdk8="export JAVA_HOME=$JAVA_8_HOME && java -version"
alias jdk11="export JAVA_HOME=$JAVA_11_HOME && java -version"
```

3. 修改完成后，保存重新编译

```bash
source ~/.zprofile
```

在终端中输入jdk7、jdk8 切换版本，通过java -version 查看版本

通过`/usr/libexec/java_home -V`查看jdk及当前使用版本

- 其他jdk：
azul版本jdk：
https://www.azul.com/

注：M1的mac在使用tinker gradle命令打补丁包时会提示SevenZip相关exe文件找不到，需要使用intel架构的jdk运行gradle命令，此依赖暂不支持arm架构