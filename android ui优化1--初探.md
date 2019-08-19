 # android ui优化初探

 ### 1 查看android布局
  [附大佬文章一篇](http://per-dyw.xyz/2019/08/15/UI%E6%A3%80%E6%B5%8B/#more)
 - 使用Layout Inspector
    > 在Android Studio(版本为3.4.2) 的Tools中可以看到Layout inspector，后续步骤不多说了
 - 使用DDMS的相关工具--Hierarchy View（折腾）
    > 使用过Eclipse开发过android的基本都知道DDMS，虽然转到android studio下，但是DDMS工具依然在android sdk中保留，新版的android studio中已经不支持从as内部打开，这里可以找到sdk下的tools目录，里面有个monitor文件，运行即可打开ddms<br/>
    在windows菜单中选择Open Perspective，选择Hierarchy View,之后你发现，并不能显示什么。这里巾帼一番百度，总结一下集中原因和方案：<br/>
    [参考1](https://www.jianshu.com/p/a2ce59503224)<br/>
    [参考2](https://www.jianshu.com/p/1ee54e3ea9fd)<br/>
    1. 使用这个查看布局需要真机的系统是开发版本，而且root，目测如果使用小米的开发版系统，手机也root，那么问题不大，应该是可以连接成功的
    2. android4.0及以下版本手机
        ```
        请根据开源项目 View  Server（https://github.com/romainguy/ViewServer） 进行安装和配置
        ```
        这种方式本人为测试
    3. 使用超级adb<br/>
        首先说下原因吧，我这里是linux的开发环境，发现
        root后的手机，使用`adb root`命令后`adbd cannot run as root in production builds`他报这个错，至于原因，因该是和上面说的第一条应该是一样的，indie我这个手机是华为正式版的系统root后的，这是跟第一条是同一个问题。<br/><br/>
        手机root后，安装这个app，这里提供[1.2](./attachment/adb\ insecure\ 1.2-20190819.apk)及[1.3](./attachment/超级adb1.3-20190819.apk)版本的app<br/>
        安装之后，注意需要root，权限而且需要开启usb调试，开启超级adb的开关，但是，这里开启之后，usb调试就被关掉了，adb命令中就不会显示这个设备了，只有吧超级adb的开关关了，再把adb调试的开关关了重开才行，所以说，这个方法并没有用。。。<br/>
        然后网上说`setenforce 0`(这个命令作用在android手机上哈)就可以了，然额，这个命令根本执行不成功，原因也是因为google的安全策略吧，不允许你这样搞。<br/>
        所以说，这个 方法行不通。。。
    4. 更改build.prop
        这个方法简单的理解就是更改系统的构建配置的文件，在/system/build.prop,目测是在这个文件中添加这两行
        ```bash
        ro.secure=0 
        ro.debuggable=1
        ```
        然后重启吧，我试了下，还是没用
    5. 这个方法比较溜
        这个方法应该就比较牛皮了，没试过。。。
        参考上述参考1 的文末的方法，可以说是相当牛皮了。（懒得折腾了）