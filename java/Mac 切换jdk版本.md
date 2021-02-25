1. 打开终端

```bash
cd
vim .bash_profile
```

2. 输入以下

```bash
export JAVA_7_HOME=`/usr/libexec/java_home -v 1.7`
export JAVA_8_HOME=`/usr/libexec/java_home -v 1.8`
export JAVA_HOME=$JAVA_8_HOME
alias jdk7="export JAVA_HOME=$JAVA_7_HOME"
alias jdk8="export JAVA_HOME=$JAVA_8_HOME"
```

Mac OSX 10.5+ 以后，官方建议`$JAVA_HOME`的设置用 `/usr/libexec/java_home` 代替
也可以写绝对路径,通过`echo $JAVA_HOME` 查看JDK路径
例如

```bash
export JAVA_7_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
export JAVA_8_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home"
```

3. 修改完成后，保存重新编译

```bash
source ~/.bash_profile
```

在终端中输入jdk7、jdk8 切换版本，通过java -version 查看版本

通过`/usr/libexec/java_home -V`查看jdk及当前使用版本
