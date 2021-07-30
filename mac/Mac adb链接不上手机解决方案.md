## 解决Mac上Android开发时adb连接不到手机问题

1. mac插入手机.打开 Terminal，输入 system_profiler  SPUSBDataType

2. 在显示结果中找  Vendor ID:

USB 3.0 Hi-Speed Bus:

```txt
      Host Controller Location: Built-in USB
      Host Controller Driver: AppleUSBXHCI
      PCI Device ID: 0x9c31
      PCI Revision ID: 0x0004
      PCI Vendor ID: 0x8086
      Bus Number: 0x0a
 
        [your phone name]:
 
          Product ID: 0x0c02
          Vendor ID: 0x2a45
          Version: ff.ff
          Serial Number: 75UBBKQ22PTN
          Speed: Up to 480 Mb/sec
          Manufacturer: Meizu
          Location ID: 0x14200000 / 7
          Current Available (mA): 500
          Current Required (mA): 192
```

3. 记下这个号,在Terminal中转到 vi  /Users/xxx/.android/adb_usb.ini  （如果没有会版创建文件）

  这里的xxx 是你电脑用户的名称，你可以先到Users下面看看你用的是那个

4. 把上面那个号插入到新的一行中,也下格式就可以

```txt
# ANDROID 3RD PARTY USB VENDOR ID  LIST
# USB 'android update adb' TO GENERATE
# USB VENDOR ID PER LINE
# MX4
0x2a45
```

重新启动ADB ok！
