# git 移除某文件的版本控制及提交记录

#### [参考](https://www.cnblogs.com/shines77/p/3460274.html)

### 1、将仓库中为文件清除
```bash
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch path-to-your-remove-file' --prune-empty --tag-name-filter cat -- --all
```
其中, path-to-your-remove-file 就是你要删除的文件的相对路径<br>

如果需要删除的是文件夹，在 ```git rm --cached ```命令后面添加 ```-r``` 命令
如果文件路径较麻烦或要删除多个文件，可使用通配符
```bash
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch sound/Music_*.mp3' --prune-empty --tag-name-filter cat -- --all
```

如果显示 xxxxx unchanged, 说明repo里没有找到该文件, 请检查路径和文件名是否正确.

### 2、push修改后的repo
```bash
git push origin master --force --all
```
我这里 --all报错，直接去除--all貌似也OK

为了能从打了 tag 的版本中也删除你所指定的文件或文件夹，您可以使用这样的命令来强制推送您的 Git tags：
```bash
git push origin master --force --tags
```

### 3、清理git目录
```bash
rm -rf .git/refs/original/

git reflog expire --expire=now --all

git gc --prune=now


Counting objects: 2437, done.
# Delta compression using up to 4 threads.
# Compressing objects: 100% (1378/1378), done.
# Writing objects: 100% (2437/2437), done.
# Total 2437 (delta 1461), reused 1802 (delta 1048)


git gc --aggressive --prune=now


Counting objects: 2437, done.
# Delta compression using up to 4 threads.
# Compressing objects: 100% (2426/2426), done.
# Writing objects: 100% (2437/2437), done.
# Total 2437 (delta 1483), reused 0 (delta 0)
```