# git常用命令整理 
 

### git remote 系列

#### 查看远程仓库
```git bash
git remote -v
```
#### 添加远程仓库
```git bash
git remote add origin your_resp_url
```
其中your_resp_url是仓库地址，origin是源

#### 重命名远程仓库
```git bash
git remote rename old_name new_name
```

#### 给某个源添加/删除远程仓库
``` git bash 
git remote set-url --add origin  your_resp_url
git remote set-url --delete origin  your_resp_url
```
其中your_resp_url是仓库地址，origin是源

