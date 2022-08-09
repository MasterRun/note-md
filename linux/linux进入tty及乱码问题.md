## tty

ctrl+alt+f1~f6 尝试，可以进入tty

## tty乱码

`/usr/bin/en`，然后设置其属性为755即可：

注意使用root权限编辑

```sh
#!/bin/sh

export LANG=en_US.UTF-8 && "$@"

```
可以执行`source en`直接生效

如果想改为中文
创建zh，并source
```sh
#!/bin/sh

export LANG=zh_CN.UTF-8 && "$@"
```