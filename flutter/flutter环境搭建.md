# flutter 环境搭建

上一波相关传送门

[flutter github地址](https://github.com/flutter/flutter)

[flutter全家桶地址](https://github.com/flutter)

[flutter官网](https://flutter.dev/)

[中文官网](https://flutter-io.cn/)

#### [使用flutter镜像](https://flutter.dev/community/china)
将对应的键值添加到环境变量，国内建议使用上海交大镜像

##### Flutter 社区镜像

FLUTTER_STORAGE_BASE_URL: https://storage.flutter-io.cn

PUB_HOSTED_URL: https://pub.flutter-io.cn

##### 清华大学 TUNA 协会

FLUTTER_STORAGE_BASE_URL: https://mirrors.tuna.tsinghua.edu.cn/flutter

PUB_HOSTED_URL: https://mirrors.tuna.tsinghua.edu.cn/dart-pub

#### 下载配置

**注：先确保Java环境后再进行以下步骤**

下载flutter最新的stable包，将以下路径添加到path环境变量
``` path
#flutter的bin
%FLUTTER_HOME%\bin

%FLUTTER_HOME%\.pub-cache\bin

#flutter内置dart的bin
%FLUTTER_HOME%\bin\cache\dart-sdk\bin
```

使用flutter进行Android开发需要安装Android studio用于配置开发环境（此处略）
注意：需要将android sdk路径添加到环境变量中，变量名为`ANDROID_HOME`

完成上述步骤后 使用  ```flutter doctor```  命令检查是否成功


  <!-- ! Some Android licenses not accepted.  To resolve this, run: flutter doctor --android-licenses -->