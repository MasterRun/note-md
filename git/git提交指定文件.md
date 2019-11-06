# git提交指定文件
[参考](https://blog.csdn.net/tangxinzhuan/article/details/89428745)

### 方式1
先将指定文件添加到 暂存区，然后提交所有 暂存区 的文件

```bash
git add index.html about.html
git commit -m '我提交了所有 暂存区 的文件'
```

### 方式2
此方式可以提交分别来自不同地方的文件，比如 工作区的 和 暂存区的
```bash
git commit -o index.html about.html -m '我同时提交了 工作区的index.html 和 暂存区的about.html 这两个文件'

```