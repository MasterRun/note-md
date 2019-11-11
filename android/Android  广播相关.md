# Android 广播相关

参考

[官方文档](https://developer.android.google.cn/guide/components/broadcast-exceptions?hl=en)

[在Android8.0上突破隐式广播的限制](https://www.jianshu.com/p/5283ebc225d5?utm_source=oschina-app)

[android 开机广播接收不到的原因](https://blog.csdn.net/baidu_27196493/article/details/78269674)

[关于手机接收不到开机广播问题](https://www.jianshu.com/p/220c4ca6a546)

target26（Android 8）及以后，不再支持静态注册广播：除开机广播除外

### 开机广播

```xml
ACTION_LOCKED_BOOT_COMPLETED， ACTION_BOOT_COMPLETED
```

开机广播仍可在target26的app中接收到，Android 10 也没问题，有些厂商例如小米华为等有app的自启动权限开关需要手动打开app的自启权限

### 关机广播

目前测试关机广播不能保证全部接收成功，可能与target26 禁止隐式广播有关

可以动态注册广播接收器接收系统的隐式广播，在app正常运行，注册了广播的activity未销毁时，可以接收到关机广播

### 应对隐式广播的限制

1. 能动态注册，就不静态注册
2. 如果一定要静态注册， 发送的时候指定包名，即发送显式广播
3. 如果要接收系统广播，而对应的广播在Android8.0中无法被接收，那么只能暂时把App的targetSdkVersion改为25或以下，但这招已经不顶用了，工信部要求targetSDK必须26以上

### 总结

1. 当targetSdkVersion升级到26之后，大部分静态注册的隐式广播会失效（例如系统关机广播：ACTION_SHUTDOWN）；
2. 当targetSdkVersion升级到26之后，有个别广播仍然能通过静态注册进行接收，如常见的系统启动广播（ACTION_BOOT_COMPLETED），Android 8、9、10都可以接收系统启动广播。但是受到手机厂商的限制，小米华为等机型需要用户手动开启app的自启动权限，app才能接收到系统的启动广播；
3. 当targetSdkVersion升级到26之后，如果需要接收隐式广播（例如系统关机广播），可以使用动态注册的方式。由于动态注册广播接收器需要绑定activity，所以在相应的activity未销毁时才能接收到广播。即如果想接收关机广播，需要在某activity中动态注册广播接收器，在此activity销毁前，去触发手机的正常关机或重启操作，可以接收到系统的关机广播。
