# 修改git提交历史

[参考](https://www.jianshu.com/p/0f1fbd50b4be)

使用rebase命令，如下会修改最近三次提交的历史
```bash
$ git rebase -i HEAD~3
```
将会得到如下的信息,这里的提交日志是和git log倒叙排列的,我们要修改的日志信息位于第一位.
```bash
  1 pick 2275781 should find method from parent
  2 pick 223fc80 unit test case
  3 pick 9ac1179 update test case
  4
  5 # Rebase 79db0bd..9ac1179 onto 79db0bd (3 commands)
  6 #
  7 # Commands:
  8 # p, pick = use commit
  9 # r, reword = use commit, but edit the commit message
 10 # e, edit = use commit, but stop for amending
 11 # s, squash = use commit, but meld into previous commit
 12 # f, fixup = like "squash", but discard this commit's log message
 13 # x, exec = run command (the rest of the line) using shell
 14 # d, drop = remove commit
 15 #
 16 # These lines can be re-ordered; they are executed from top to bottom.
 17 #
 18 # If you remove a line here THAT COMMIT WILL BE LOST.
 19 #
 20 # However, if you remove everything, the rebase will be aborted.
 21 #
 22 # Note that empty commits are commented out
```
将需要修改的历史 状态从pick改为edit，使用`:wq`保存退出

将会看到如下信息,意思就是如果要改日志,执行git commit --amend,如果修改完成后,执行git rebase --continue

```bash
client_java git:(fix_aop_no_class_defined) git rebase -i HEAD~3
Stopped at 2275781...  should find method from parent
You can amend the commit now, with

  git commit --amend

Once you are satisfied with your changes, run

  git rebase --continue
➜  client_java git:(2275781)

```

接下来使用amend修改
```bash
 git commit --amend -s 
 ```

 修改完成后,:wq 退出,然后完成此次 log 的rebase

 ```bash
 git rebase --continue
 ```
- 如果修改多条，则会继续修改下一条

完成后push
```bash
git push origin <you_branch_name> -f
```

ok!