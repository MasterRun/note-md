# Android开发技巧介绍

## Android Studio使用

### 常用配置

- 演示模式
- 全屏模式
- 无干扰模式
![Android Studio样式](../attachment/pic_androidskills/android_studio_view_mode.png)

- 字体  
- 文字大小  

- 导入导出配置
![导入导出](../attachment/pic_androidskills/export_inport_settings.png)

- vm配置
![vm配置](../attachment/pic_androidskills/custom_vm_options.png)

```porp
-Xms1024m
-Xmx3096m
-XX:ReservedCodeCacheSize=1024m
-XX:+UseConcMarkSweepGC
-XX:SoftRefLRUPolicyMSPerMB=100
-Dsun.io.useCanonCaches=false
-Djava.net.preferIPv4Stack=true
-Djna.nosys=true
-Djna.boot.library.path=

-Dfile.encoding=UTF-8

-da
```

- tools
- 操作栏编辑
- 自动导包
- 自定义快捷键

### 快捷键

- Ctrl E 最近任务/窗口切换

- Alt 1、2、3、4、5、6、7、8、9  切换工具窗口

- Alt -> <-  切换上一个/下一个tab

- Ctrl Shift L 格式化代码

- Ctrl Shift N 搜索文件

- Ctrl Shift F 全局搜索

- Ctrl Alt F 将局部变量提升为成员变量

- Ctrl Shift U 大小写切换

- Ctrl D 复制行

- Ctrl X 剪切/删除行

- Shift F10 运行

- Shift F9 调试

- Shift Esc 隐藏窗口

### Gradle及android—gradle插件

android-gradle 3.4.0 R8混淆

### SVN配置及使用

### 实用插件

#### Gradle View

命令

#### Code Glance

#### Easy Gradle

#### ADB Idea

#### Rainbow Brackets

## 代码快捷操作

- psfs -> public static final String
- psfi -> public static final int

- Sround with： Ctrl Shift T -> 将选中的代码进行指定代码块的包裹，包括 try catch 、 if 、 region 等

- 代码块折叠/展开
  - Ctrl -
  - Ctrl +
  - Ctrl Shift +
  - Ctrl Shift -

快捷键及debug操作等

建议在方法的入参、返回值及类的成员变量上添加
@NonNull
@Nullable

## ViewBinding

视图绑定

Android Studio升级到4.0+

distribution¡¡¡¡¡Url=https\://services.gradle.org/distributions/gradle-6.1.1-all.zip

classpath 'com.android.tools.build:gradle:4.0.1'

buildFeatures {
    dataBinding = true
    viewBinding = true
}

## 拉不到包解决方案

本机仓库

## QMUI常用控件介绍

com.qmuiteam.qmui.layout.IQMUILayout
com.qmuiteam.qmui.layout.QMUIButton
com.qmuiteam.qmui.layout.QMUIFrameLayout
com.qmuiteam.qmui.layout.QMUI***Layout

com.qmuiteam.qmui.widget.roundwidget.QMUIRoundButton
com.qmuiteam.qmui.widget.roundwidget.QMUIRoundFrameLayout
com.qmuiteam.qmui.widget.roundwidget.QMUIRound***Layout

com.qmuiteam.qmui.widget.QMUIRadiusImageView

## 调试工具

开发者助手

抓包工具
