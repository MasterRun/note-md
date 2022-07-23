# git 配置ssh

注：本文环境 manjaro(linux),windows使用git bash应该也可以的

[参考](https://blog.csdn.net/u013778905/article/details/83501204)

git 提供两种方式remote链接的形式，分别是ssh和https，使用https链接在每次`git push`都需要输入用户名和密码，而是用ssh，配置认证后就可以直接push

### 1. 设置git的user name和email
首先如果没有配置用户名和邮箱的话，还是配置以下git的全局配置吧
```bash
#使用你想用的名字
git config --global user.name "jsongo"
#以下邮箱使用自己的邮箱吧
git config --global user.email  "jsongo@jsongo.com"
```
说明：git config --list 查看当前Git环境所有配置
### 2. 检查是否存在SSH Key
```bash
ls ~/.ssh
#看是否存在 id_rsa 和 id_rsa.pub文件，如果存在，说明已经有SSH Key
```
如果有的话，应该类似以下三个文件
```bash
id_rsa  id_rsa.pub  known_hosts
```
如果没有，需要生成，如下操作
```bash
#下面可以换成你的邮箱
ssh-keygen -t rsa -C "jsongo@jsongo.com"
```
生成之后，如果你没指定生成的位置，会在 上述的位置中生成对应的文件，找到你的`id_rsa.pub`，拷贝里面的内容，就是ssh key
### 3.在github配置你的key
登录github，在个人设置中找到ssh，选择New SSH Key，起一个名字，将上面复制的值填入即可。（gitee操作类似）
### 4.验证和使用
验证如下
```bash
ssh -T git@github.com
# 应出现类似如下内容
Hi someone! You ve successfully authenticated, but GitHub does not provide shell access.
```
之后就可以将https链接换成ssh链接，避免每次git push都要输入帐号密码。
换链接的两种方式式
- 使用git命令原来的remote重新添加 [参考笔记](./git常用命令整理.md)
- 直接将.git文件夹中config文件中的链接替换



## 使用repo
https://blog.csdn.net/ysy950803/article/details/104188793