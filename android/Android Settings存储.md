# Android Settings存储

## 使用

```kotlin
    //put  需要系统应用，且需要权限 <uses-Manifest.permission android:name="android.permission.WRITE_SECURE_SETTINGS" />
    Settings.Secure.putString(contentResolver, KEY, "secure:" + System.nanoTime())
    Settings.System.putString(contentResolver, KEY, "system:" + System.nanoTime())
    Settings.Global.putString(contentResolver, KEY, "global:" + System.nanoTime())
    //get 无需权限
    Settings.Secure.getString(contentResolver, KEY)
    Settings.System.getString(contentResolver, KEY)
    Settings.Global.getString(contentResolver, KEY)
```

## 存储位置

- 旧版本Android
  
  将settings数据存在数据库中，{system, secure, global} 对应的是 `/data/data/com.android.providers.settings/databases/settings.db` 的三个表

- 新版本使用xml文件存储
  
  一般位于 `/data/system/users/0`目录下，该目录的`settings_global.xml`，`settings_secure.xml`和`settings_system.xml`三个xml文件就是SettingsProvider中的数据文件。

 
## adb操作

```bash
#获取值

adb shell settings get system [key]

adb shell settings get global [key]

adb shell settings get secure [key]

#设置值

adb shell settings put system [key] [value]

adb shell settings put global [key] [value]

adb shell settings put secure [key] [value]
```