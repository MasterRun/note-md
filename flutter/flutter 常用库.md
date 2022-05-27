# Flutter社区、资源、常用库

[本文参考](https://www.cnblogs.com/yangyxd/p/9232308.html)

- [Flutter社区、资源、常用库](#flutter社区资源常用库)
    - [相关资源网站](#相关资源网站)
    - [常用库](#常用库)
      - [1. 网络请求](#1-网络请求)
      - [2. 图像加载](#2-图像加载)
      - [3. 图像处理](#3-图像处理)
      - [4. UI相关](#4-ui相关)
      - [5. 视频 & 音频](#5-视频--音频)
      - [6. 路由和消息传递](#6-路由和消息传递)
      - [7. 数据存储、缓存有关的库](#7-数据存储缓存有关的库)
      - [8. 类型编解码的库](#8-类型编解码的库)
      - [9. 序列化](#9-序列化)
      - [10. Json解析](#10-json解析)
      - [11. 国际化和本地化](#11-国际化和本地化)
      - [12. rx系列](#12-rx系列)
      - [13. 系统平台有关的库](#13-系统平台有关的库)
      - [14. 权限库](#14-权限库)
      - [15. 地图（地图显示、定位、经纬度等）](#15-地图地图显示定位经纬度等)
      - [16. 二维码](#16-二维码)
      - [17. WebView](#17-webview)
      - [18. 图表库](#18-图表库)
      - [19. 其它](#19-其它)
      - [20. 学习资料](#20-学习资料)

### 相关资源网站

[字体图标生成](http://fluttericon.com/)

[Flutter中文网](https://flutterchina.club)

[Flutter官网](https://flutter.io)

[Flutter中文开发者论坛](http://flutter-dev.cn/)

[Flutter|Dart语言中文社区](http://www.cndartlang.com/flutter)

[Dart开源包](https://pub.dartlang.org/packages)

[Dart SDK文档](https://api.dartlang.org/stable/1.24.3/index.html)

[学习资料](https://marcinszalek.pl/)

[Flutter布局控件](https://juejin.im/post/5bab35ff5188255c3272c228)

[Flutter开发者](http://flutter.link/)

[Flutter开源APP](https://itsallwidgets.com/)

[深入理解（Flutter Platform Channel ）](https://www.jianshu.com/p/39575a90e820)

[简书 - 闲鱼技术](https://www.jianshu.com/u/cf5c0e4b1111)

### 常用库
#### 1. 网络请求
- http  
 > https://pub.dartlang.org/packages/http <br>
 > https://github.com/dart-lang/http <br>
 > 该软件包包含一组高级函数和类，可以轻松使用HTTP资源。它与平台无关，可以在命令行和浏览器上使用。
- dio
 > https://pub.dartlang.org/packages/dio <br>
 > Dart的一个强大的Http客户端，支持拦截器、全局配置、FormData、请求取消、文件下载、超时等。 
- http_multi_server
 > https://pub.dartlang.org/packages/http_multi_server <br>
 > dart:io HttpServer包装器，用于处理来自多个服务器的请求

#### 2. 图像加载
- 可使用 Image.network 、 FadeInImage.memoryNetwork 或下面的库加载。
- cached_network_image
 > https://pub.dartlang.org/packages/cached_network_image <br>
 > Flutter库来加载和缓存网络图像。也可以与占位符和错误小部件一起使用。
- flutter_advanced_networkimage
 > https://pub.dartlang.org/packages/flutter_advanced_networkimage <br>
 > 高级图像缓存加载和缩放控制。
- transparent_image
 > https://pub.dartlang.org/packages/transparent_image <br>
 > 简单的透明图像，表示为Uint8List。在加载图片时可以用来做为占位符。

#### 3. 图像处理
- image_jpeg
 > https://pub.dartlang.org/packages/image_jpeg <br>
 > https://github.com/yangyxd/image_jpeg
 > 用于图像上传之前转jpeg缩放压缩，调用Android或iOS原生功能进行处理，性能较高，支持的源图像格式也更多。
- image_picker
 > https://pub.dartlang.org/packages/image_picker <br>
 > 用于从Android和iOS图像库中选择图像，并使用相机拍摄新照片。
- photo
 > https://pub.dartlang.org/packages/photo <br>
 > 用于选择图像，支持多选，而且这个是用Flutter做的UI，可以很方便的自定义修改（强烈推荐）。
- image
 > https://pub.dartlang.org/packages/image <br>
 > DART库，提供以各种不同的文件格式加载、保存和操作图像的能力。该库不依赖于DART：IO，因此它可以用于服务器和Web应用程序。
- flutter_svg
 > https://pub.dartlang.org/packages/flutter_svg <br>
 > 加载svg图像。
- zoomable_image
 > https://pub.dartlang.org/packages/zoomable_image <br>
 > 提供图像查看和手势缩放操作功能。
- image_carousel
 > https://pub.dartlang.org/packages/image_carousel <br>
 > Flutter图像展示控件，可以左右划动切换上一张下一张图像，还结合了zoomable_image可以点击后缩放查看。支持Asset和网络图像。
- carousel_slider
 > https://pub.dartlang.org/packages/carousel_slider <br>
 > 一个支持手势划动和自动播放的图像展示控件。
- parallax_image
 > https://pub.dartlang.org/packages/parallax_image <br>
 > 视差图像可以与任何可滚动（例如ListVIEW）一起使用。说白了就是让放在滚动区域内的图像滚动时看起来更平滑。
- camera
 > https://pub.dartlang.org/packages/camera <br>
 > 用于在Android和iOS上获取有关和控制相机的信息。支持预览相机馈送和捕捉图像。

#### 4. UI相关
- fluttertoast
 > https://pub.dartlang.org/packages/fluttertoast <br>
 > 用于Android和ios的toast库。
- flutter_html_view
 > https://pub.dartlang.org/packages/flutter_html_view <br>
 > Flutter没有默认的支持来显示html，所以需要三方的包来显示。这个包可以将html呈现给原生的Widget。（目前支持的标签比较少）
- flutter_html_textview
 > https://pub.dartlang.org/packages/flutter_html_textview <br>
 > 将html呈现为一个Widget,在textview中呈现html。
- markdown
 > https://pub.dartlang.org/packages/markdown <br>
 > 用Dart编写的便携式Markdown库。它可以在客户端和服务器上将Markdown解析为HTML。
- html2md
 > https://pub.dartlang.org/packages/html2md <br>
 > 将html转换为Dart中的MarkDown.
- flutter_calendar  （日历）
 > https://pub.dartlang.org/packages/flutter_calendar <br/>
 > 日历组件.
- flutter_picker
 > https://pub.dartlang.org/packages/flutter_picker <br>
 > https://github.com/yangyxd/flutter_picker <br>
 > 选择器。可以根据json或自定义数据生成选择器。
- flutter_spinkit
 > https://github.com/jogboms/flutter_spinkit <br>
 > 加载动画。支持多种常用效果，非常酷炫。 
- extended_nested_scroll_view
 > https://github.com/zmtzawqlp/Flutter_Candies/tree/master/extended_nested_scroll_view <br>
 >  一个扩展NestedScrollView，能够更好的处理列表、TabView、Sliver混合的情况（但是这个插件没有在pub找到）
- badge
 > https://pub.dartlang.org/packages/badge <br>
 > 小红点插件，可以用来显示小红点、未读消息数量等，非常方便
- flutter_staggered_grid_view （瀑布流）
 > https://pub.dev/packages/flutter_staggered_grid_view <br>
 > 瀑布流列表插件，可以支持不同大小的列。

#### 5. 视频 & 音频
- chewie
 > https://pub.dartlang.org/packages/chewie <br>
 > 视频播放器，在video_player的基础上包装了控制UI。
- video_player
 > https://pub.dartlang.org/packages/video_player <br>
 > 用于在Android和iOS上与其他Flutter窗口小部件一起显示内嵌视频。
- video_launcher
 > https://pub.dartlang.org/packages/video_launcher <br>
 > 视频播放器，可播放本地文件和字节流。
- flute_music_player
 > https://pub.dartlang.org/packages/flute_music_player <br>
 > 基于Flutter的材料设计音乐播放器与音频插件播放本地音乐文件。自带华丽的播放界面。
- audioplayer
 > https://pub.dartlang.org/packages/audioplayer <br>
 > 一个播放远程或本地音频文件Flutter音频插件
- audioplayers
 > https://pub.dartlang.org/packages/audioplayers <br>
 > 这是rxlabz的audioplayer的一个分支，不同之处在于它支持同时播放多个音频并显示音量控制。
- spritewidget
 > https://pub.dartlang.org/packages/spritewidget <br>
 > SpriteWidget是用于构建复杂、高性能动画和带有2D游戏的插件包，可与其它小部件无缝混合。您可以使用SpriteWidget创建任何东西，从动画图标到成熟的游戏。

#### 6. 路由和消息传递
- fluro
 > https://pub.dartlang.org/packages/fluro <br>
 > https://github.com/theyakka/fluro <br>
 > 最好用的路由导航框架。功能：简单的路线导航；函数处理程序（映射到函数而不是路径）；通配符参数匹配；查询字符串参数解析；内置常用转换；简单的定制转换创建。
- flutter_local_notifications
 > https://pub.dartlang.org/packages/flutter_local_notifications <br>
 > 一个跨平台的显示本地notifications的插件。
- local_notifications
 > https://pub.dartlang.org/packages/local_notifications <br>
 > 这个库能让你在Android和iOS上创建Notifications很简单。
- url_launcher
 > https://pub.dartlang.org/packages/url_launcher <br>
 > 用于在Android和iOS上启动URL。支持网络，电话，短信和电子邮件方案。
- firebase_messaging
 > https://pub.dartlang.org/packages/firebase_messaging <br>
 > 一款跨平台的消息传递解决方案，可让您在Android和iOS上可靠地传递消息。
- flutter_msg_engine
 > https://pub.dartlang.org/packages/flutter_msg_engine <br>
 > https://github.com/yangyxd/flutter_msg_engine <br>
 > 消息引擎, 注册一个消息，在任何地方响应并处理。。
- event_bus
 > https://pub.dartlang.org/packages/event_bus  <br>
 > 一个使用Dart流进行解耦应用程序的简单事件总线的库。

#### 7. 数据存储、缓存有关的库
- sqflite
 > https://pub.dartlang.org/packages/sqflite <br>
 > SQLite的Flutter插件，一个自包含的高可靠性嵌入式SQL数据库引擎。
- file_cache
 > https://pub.dartlang.org/packages/file_cache <br>
 > 为flutter package项目缓存Json,Buffer,FileCacheImage。
- flutter_cache_manager
 > https://pub.dartlang.org/packages/flutter_cache_manager <br>
 > 管理你的app下载到本地的文件缓存。它使用缓存控制HTTP报头有效地检索文件。

#### 8. 类型编解码的库
- html_unescape
 > https://pub.dartlang.org/packages/html_unescape <br>
 > 用于解决HTML编码字符串的Dart库。支持所有命名字符引用（如&nbsp;），小数字符引用（如&#225;）和十六进制字符引用（如&#xE3;）。
- html
 > https://pub.dartlang.org/packages/html <br>
 > HTML解析库。
- crypto
 > https://pub.dartlang.org/packages/crypto
 > 在纯DART中实现的加解密函数库。支持SHA-1、SHA-256、MD5、HMAC
#### 9. 序列化
- 手动序列化：
 > 使用 dart:convert 的内置解码器。包括传入 JSON 原始字符串给 JSON.decode() 方法，然后从 Map<String, dynamic> 中查询你需要的数据。
- 自动序列化：
  
| 库名                  | 版本号 | 链接                                                    | 描述          |
| --------------------- | ------ | ------------------------------------------------------- | ------------- |
| json_serializable     | 0.5.7  | https://pub.dartlang.org/packages/json_serializable     |               |
| built_value           | 5.5.1  | https://pub.dartlang.org/packages/built_value           | runtime依赖项 |
| built_value_generator | 5.5.1  | https://pub.dartlang.org/packages/built_value_generator | dev依赖项     |
| built_value_test      | 5.5.1  | https://pub.dartlang.org/packages/built_value_test      | test依赖项    |


#### 10. Json解析
   - https://github.com/javiercbk/json_to_dart 根据json生成Dart实体类
   - https://pub.dartlang.org/packages/json_schema json解析
   - https://github.com/debuggerx01/JSONFormat4Flutter 这是一个AS的辅助插件，将JSONObject格式的String解析成Dart的实体类 <br>
   - Dson 0.13.2 下载地址 https://pub.dartlang.org/packages/dson <br>
   - Dartson是一个Dart库，可用于将Dart对象转换为JSON字符串。 https://github.com/eredo/dartson （用于web）

几个Json库的比较：https://github.com/drails-dart/dart-serialise

| 方式              | 大小 (js) | 序列化 (dart) | 反序列化 (dart) | 序列化 (js) | 反序列化 (js) |
| ----------------- | --------- | ------------- | --------------- | ----------- | ------------- |
| json_serializable | 80 KB     | 9.09 ms       | 6.61 ms         | 8.23 ms     | 8.12 ms       |
| Serializable      | 79 KB     | 6.1 ms        | 6.92 ms         | 4.37 ms     |
| DSON              | 94 KB     | 12.72 ms      | 11.15 ms        | 16.64 ms    | 17.94 ms      |
| Dartson           | 86 KB     | 9.61 ms       | 6.81 ms         | 8.58 ms     | 7.01 ms       |
| Manual            | 86 KB     | 8.29 ms       | 5.78 ms         | 10.7 ms     | 7.9 ms        |
| Interop           | 70 KB     | 61.55 ms      | 14.96 ms        | 2.49 ms     | 2.93 ms       |
| Jaguar_serializer | 88 KB     | 8.57 ms       | 6.58 ms         | 10.31 ms    | 8.59 ms       |
| Jackson (Groovy)  |           | 496 ms        | 252 ms          | n/a         | n/a           |
 

#### 11. 国际化和本地化
- intl
> https://pub.dartlang.org/packages/intl <br>
> 这个包提供国际化和本地化功能，包括消息翻译、复数和性别、日期/数字格式和解析以及双向文本。

#### 12. rx系列
- rxdart
> https://pub.dartlang.org/packages/rxdart <br>
> RxDart是一种基于ReactiveX的谷歌Dart反应性函数编程库。谷歌Dart自带了一个非常不错的流API;RxDart没有尝试提供这个API的替代方案，而是在它上面添加了一些功能。
- rx_widgets
> https://pub.dartlang.org/packages/rx_widgets <br>
> rx_widgets是一个包含基于流的Flutter Widgets和Widget帮助程序/便利类的程序包，它们有助于反应式编程风格，特别是与RxDart和RxCommands结合使用。
- rx_command
> https://pub.dartlang.org/packages/rx_command <br>
> RxCommand是针对事件处理程序的基于Reactive Extensions（Rx）的抽象。它基于ReactiveUI框架的ReactiveCommand。它大量使用了RxDart包。

#### 13. 系统平台有关的库
- path_provider  (获取本地文件)
> https://pub.dartlang.org/packages/path_provider <br>
> 用于获取Android和iOS文件系统上的常用位置，例如temp和app数据目录。
- shared_preferences  (读写sp文件)
> https://pub.dartlang.org/packages/shared_preferences <br>
> 用于读写简单键值对的Flutter插件。包装iOS上的NSUserDefaults和Android上的SharedPreferences。
- connectivity  (网络状态)
> https://pub.dartlang.org/packages/connectivity <br>
> 用于发现Android和iOS上的网络状态（WiFi和移动/蜂窝）连接。
- device_info  (设备信息)
> https://pub.dartlang.org/packages/device_info <br>
> 提供有关设备（品牌，型号等）的详细信息，以及应用程序正在运行的Android或iOS版本。
- flutter_blue  (蓝牙)
> https://pub.dartlang.org/packages/flutter_blue <br>   
> 这是跨平台的蓝牙sdk.
- share  (分享)
> https://pub.dartlang.org/packages/share <br>
> 支持分享的flutter插件
- open_file  (打开文件)
> https://pub.dartlang.org/packages/open_file <br>
> 调用平台打开文件。比如直接打开一个apk文件会调起平台的安装向导。

#### 14. 权限库
 - simple_permissions
 > https://pub.dartlang.org/packages/simple_permissions <br>
 > 用于android和ios的请求权限的库
 - flutter_simple_permissions
 > https://pub.dartlang.org/packages/flutter_simple_permissions

#### 15. 地图（地图显示、定位、经纬度等）
- map_viewr
> https://pub.dartlang.org/packages/map_view <br>
> 一个用于在iOS和Android上显示谷歌地图的Flutter插件
- flutter_map
> https://pub.dartlang.org/packages/flutter_map <br>
> 基于leaflet的Flutter地图包
- location
> https://pub.dartlang.org/packages/location <br>
> 这个插件 处理Android和iOS上的位置。它还提供位置更改时的回调。
- latlong
> https://pub.dartlang.org/packages/latlong <br>
> LatLong是一个计算通用的纬度和经度的轻量级库。
- flutter_amap
> https://pub.dartlang.org/packages/flutter_amap <br>
> 高德地图3d flutter组件。展示原生android、ios高德地图，并与flutter交互。

#### 16. 二维码
- barcode_scan
> https://pub.dartlang.org/packages/barcode_scan <br>
> 用于扫描2D条形码和QRCodes的Flutter插件。
- qrcode_reader
> https://pub.dartlang.org/packages/qrcode_reader <br>
> 使用相机读取二维码的Flutter插件。

#### 17. WebView
- flutter_webview_plugin
> https://pub.dartlang.org/packages/flutter_webview_plugin <br>
> 允许Flutter与原生Webview进行通信的插件。

#### 18. 图表库
- charts-common
> https://pub.dartlang.org/packages/charts_flutter <br>
> Material Design风格的图表库
- charts-flutter
> https://pub.dartlang.org/packages/charts_common <br>
> 通用的图表库组件
- flutter_circular_chart
> https://pub.dartlang.org/packages/flutter_circular_chart <br>
> 一个让你使用flutter轻松创建的动画圆形图控件的库。

#### 19. 其它
- pwa
> https://pub.dartlang.org/packages/pwa <br>
> 基于Dart的PWA应用程序的库
- fluwx (微信)
> https://pub.dartlang.org/packages/fluwx <br>
>  适用于Flutter的微信SDK，方便快捷。 QQ群：892398530。
- alipay_me (支付宝)
> https://pub.dartlang.org/packages/alipay_me <br>
> 支付宝插件，支持登录、支付。android还支持本地计算签名。
- flutter_qq  (QQ)
> https://pub.dartlang.org/packages/flutter_qq <br>
> QQ登录、分享到QQ、分享到QQ空间。

#### 20. 学习资料
- https://github.com/AweiLoveAndroid/Flutter-learning <br>
网友阿韦整理的学习资料和demo.

[政采云Flutter低成本屏幕适配方案探索](https://juejin.cn/post/7078816723666731021)
