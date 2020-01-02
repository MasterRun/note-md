方式1：

在AndroidManifest的Activity声明标签中添加  `android:documentLaunchMode`属性

当此属性值为`always`,每次启动activity都会在最近列表中添加一项
当此属性值为`intoExisting`时,会复用最近列表中已有的此activity，否在就添加一个

方式2：

在启动activity的Intent上添加Flag

```java
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT);
        intent.addFlags(Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
```

当只添加`FLAG_ACTIVITY_NEW_DOCUMENT`时，与`android:documentLaunchMode="intoExisting"`作用相同
当`FLAG_ACTIVITY_NEW_DOCUMENT`与`FLAG_ACTIVITY_MULTIPLE_TASK`都添加时，与`android:documentLaunchMode="always"`作用相同

[android动态切换logo和label](https://blog.csdn.net/nongminkouhao/article/details/84952295)

```java
activity.setTaskDescription(new ActivityManager.TaskDescription("label", Bitmap.createBitmap()));
```
