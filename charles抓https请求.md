# Charles抓https请求

[Charles官网](https://www.charlesproxy.com/)  
[破解工具](https://www.zzzmode.com/mytools/charles/)  
[参考1](https://www.jianshu.com/p/4635aa405568)  
[参考2](https://blog.csdn.net/M_15915899719/article/details/81323305)

### 安装证书
#### PC端
> Charles的工具栏 Help -> SSL Proxying  -> Intall Charles Root Certificate 进行证书的安装（我这里貌似没能装上）
#### 手机端
> <p>Help -> SSL Proxying -> Install Charles Root Certificate on a Mobile Device or Remote Browser  
> 
> 会有个弹窗，手机与电脑连接在统一局域网内，设置手动代理为提示的ip和port，访问网址，下载证书，应该是 chls.pro/ssl  
> 
> 下载下来的文件可能是 *.pem格式，重命名为  *.crt 格式，然后在手机的设置，系统安全相关的 加密凭据 中，选则 从设备安装。
> 
> 之后选择Charles工具栏的Proxy -> SSL Proxying Setting... 在弹窗中勾选 Enable SSL Proxying 并在下面的列表中添加 `*.*  *.443` ,点击ok，在抓包应该就可以老