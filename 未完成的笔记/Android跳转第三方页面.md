# Android 跳转第三方页面

## 显示intent打开第三方页面

要求：被打开的页面需要显示或隐式的将 Activity 的 exported属性设置为true方可打开

```txt
显示设置exported属性：在清单文件中将activity标签的exported值设置为true

隐式设置exported属性：在清单文件中，activity有 intent-filter 子标签
```

使用显示intent打开指定页面

```kotlin
val intent = Intent()
val packageName = "com.example.demo"
val className = "com.example.demo.MainActivity"
intent.component = ComponentName(packageName, className)
//判断目标Activity是否存在
val activityInfo = intent.resolveActivity(packageManager, PackageManager.MATCH_DEFAULT_ONLY)
if(activityInfo != null){
    context.startActivity(intent)
}
```

## 隐式intent打开第三方页面

需要目标activity至少设置一组action、category，category可用默认的`android.intent.category.DEFAULT` `Intent.CATEGORY_DEFAULT`

如果有Data，需要符合Data规则

```kotlin
context.startActivity(Intent().apply(
    action = "com.example.demo.action1"
    addCategory(Intent.CATEGORY_DEFAULT)
    setPackage("com.example.demo")
    intent.setDataAndType("")
))
```

## 仅打开第三方APP

```kotlin
val packageName = "com.example.demo"
val intent = context.packageMnager.getLaunchIntentForPackage(packageName)
//如果目标App没有默认的入口Activity，intent为null
intent?.let{
    context.startActivity(it);
}
```
