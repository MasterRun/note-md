# Epson打印机打印软件测试及APP打印跳转

#### 测试的打印机：Epson WF-100

desc:此打印机支持连接WiFi或扩散WiFi，保持在统一网段下，软件可连接打印，还支持micro usb与电脑usb连接

以下测试使用WiFi方式在统一网段连接打印机

#### 软件连接测试

| 软件名 | 支持的平台 | 支持的文件格式 | 备注 |
| --- | --- | --- | --- |
|PrinterShare| android 其余平台未知 |文档、图片、pdf等|连接打印机以及文件预览需要卸载驱动，此过程比较慢。<br>另此软件正式版需要[收费](http://www.printershare.com/buy-android-bulk.sdf)|
|AirPrint| ios 无android|-|-|
|Google Cloud Print| android 其余平台未知|-|需要google账号，具体过程未验证，不推荐|
|Email print | android 其余平台未知|-|发送邮件打印，未验证|
|Epson iprint mobile app| android  其余平台未知|仅图片、pdf|不收费、无需驱动、连接打印机可能有时稍慢|
|Remote print driver| PC 不支持移动端|-|-|

#### Android APP直接跳转Epson iprint的pdf打印预览界面进行打印

跳转其他APP的activity首先要确定目标activity必须 将export设置为true（通过三方软件可以很容易看到例如：X-plore文件管理软件），在确定这一点之后，可以反编译APP分析跳转目标activity需要的参数

[思路参考](https://blog.csdn.net/tyyj90/article/details/49962009)

建议使用FileProvider，以防APP闪退
```java
public class aActivity extends AppCompatActivity {
    
    public void goEpsonPrintPreview(String path){
         String epsonPrintApkPackageName = "epson.print";
         Intent intent = new Intent();
         intent.setAction("android.intent.action.SEND");
         intent.setPackage(epsonPrintApkPackageName);
         intent.setClassName(epsonPrintApkPackageName,"epson.print.ActivityDocsPrintPreview");
         
         Uri uri = FileProvider.getUriForFile(aContext, aContext.getPackageName() + ".provider", new File(path));

         intent.putExtra("android.intent.extra.STREAM", uri);
         intent.setType("application/pdf");
         intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
         intent.addCategory(Intent.CATEGORY_DEFAULT);
         startActivity(intent);
    }
}
```
