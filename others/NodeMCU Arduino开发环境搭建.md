# NodeMCU Arduino开发环境搭建

[参考太极创客](http://www.taichi-maker.com/)

开发板：ESP8266 CH340、CP210x

此处使用Windows系统，Mac系统驱动支持不好

## 安装开发板驱动

[参考](http://www.taichi-maker.com/homepage/esp8266-nodemcu-iot/iot-c/install-esp8266-nodemcu-driver/)

注意开发板是CH340还是cp210x，需要不同的驱动

如果设备管理器不显示端口，尝试以下两种操作

- 查看—>显示隐藏的设备
- 操作—>添加过时硬件—>找到相应的驱动

## 使用Arduino IDE开发

[参考](http://www.taichi-maker.com/homepage/esp8266-nodemcu-iot/iot-c/nodemcu-arduino-ide/)

- 下载安装Arduino，首选项—>开发板管理器网址添加`http://arduino.esp8266.com/stable/package_esp8266com_index.json`
- `工具—> 开发板 —> 开发板管理器`，搜索e`sp8266`，安装2.x.x版本的开发板管理器（此过程较慢可以科学上网）
- 选择`工具—> 开发板 —>NodeMCU 1.0`
- `工具—> 端口`选择您的开发板连接的端口
- 打开Blinker示例程序，上传至开发板验证开发板是否正常

- 在`工具—> 管理库中`可以查找您所需的库文件进行下载，下载的库文件保存在`${USER_HOME}/Documents/Arduino/libraries`中，您页可以手动向其中添加文件
