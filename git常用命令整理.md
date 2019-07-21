# git常用命令整理 

### git remote 系列

#### 查看远程仓库
```git bash
git remote -v
```
#### 添加远程仓库
```git bash
git remote add origin your_depo_url
```
其中your_depo_url是仓库地址，origin是源

#### 重命名远程仓库
```git bash
git remote rename old_name new_name
```

#### 更改源的远程仓库url
```git bash
git remote set-url origin you_depo_url
```
其中your_depo_url是仓库地址，origin是源

#### 给某个源添加/删除远程仓库url
``` git bash 
git remote set-url --add origin  your_depo_url
git remote set-url --delete origin  your_depo_url
```
其中your_depo_url是仓库地址，origin是源

<br><br>

### git push 系列

#### 使用 -v 查看命令执行的详情

#### 切换push的源和分支
当有多个源或多分支时，git push只会上传到某一源的一个分支，使用如下命令切换源及分支
```git bash
 git push -u origin master
 git push --set-upstream origin master
```
其中origin为你要上传的源 master为你要上传的分支

#### 删除远程分支
```git bash
git push origin --delete branch_name
```
origin 是对应的源  branch_name是需要删除的远程分支


### git branch 系列
查看分支

#### 查看所有分支（本地+远程）
```git bash
git branch -a
```

#### 删除本地分支
```git bash
git branch -d branch_name
```
branch_name是需要删除的本地分支

#### 移动/重命名分支
```git bash
git branch -m old_branch new_branch 
```