
## 开发工具使用Jenkins插件

1. 安装Jenkins Control
2. Server Address为`https://{ip}:{port}`
3. username为您注册的用户名
4. Password/API-Token输入您的API-Token,在Jenkins平台登录后，依次：右上角您的用户名->设置->API Token->添加新token
5. Crumb Data可从`http://{ip}:{port}/crumbIssuer/api/json`(http://<username>:<password>@{ip}:{port}/crumbIssuer/api/json)获取，如果你不输入，保存后将询问您的系统密码（此方式也可）
6. Jenkins Version一般选择`ver 2.x`
7. 点击Test Connection
8. 完成后可在右侧看到jenkins插件面板
9. Enjoy it!

PS: Jenkins插件的配置伴随着项目的.idea文件夹，如果文件夹被清理，需要重新配置