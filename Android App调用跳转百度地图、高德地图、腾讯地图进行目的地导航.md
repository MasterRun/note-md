# Android App调用跳转百度地图、高德地图、腾讯地图进行目的地导航

先放上百度、高德、腾讯地图调起API文档地址，有些参数不懂可以参考。

[百度地图](http://lbsyun.baidu.com/index.php?title=uri/api/android)
[高德地图](https://lbs.amap.com/api/amap-mobile/guide/android/navigation)
[腾讯地图](http://lbs.qq.com/uri_v1/guide-mobile-navAndRoute.html)

### 1、坐标系
#### 1.1 坐标系的种类
目前坐标系有三种，分别是WGS84、GCJ02、BD09，国内基本用的是后两种。
WGS84：国际坐标系，为一种大地坐标系，也是目前广泛使用的GPS全球卫星定位系统使用的坐标系。
GCJ02：火星坐标系，是由中国国家测绘局制订的地理信息系统的坐标系统。由WGS84坐标系经加密后的坐标系。高德、腾讯都是用的这种。
BD09：为百度坐标系，在GCJ02坐标系基础上再次加密。其中BD09ll表示百度经纬度坐标，BD09mc表示百度墨卡托米制坐标。百度地图sdk默认输出的是BD09ll，定位sdk默认输出的是GCJ02。

### 2、调用跳转第三方地图进行导航
#### 2.1 检测是否安装第三方地图
在调用跳转第三方地图进行导航前需要检查手机是否安装有要跳转的第三方地图，检测方法如下，有安装返回true，否则返回false。
```Java
class AClass{
    /**
      * 检测程序是否安装
      *
      * @param packageName
      * @return
      */
    private boolean isInstalled(String packageName) {
        PackageManager manager = getContext().getPackageManager();
        //获取所有已安装程序的包信息
        List<PackageInfo> installedPackages = manager.getInstalledPackages(0);
        if (installedPackages != null) {
            for (PackageInfo info : installedPackages) {
                if (info.packageName.equals(packageName)) {
                    return true;
                }
            }
        }
        return false;
    }
}
```
#### 2.2 跳转三方地图
##### 2.2.1 百度地图
跳转百度地图导航的URL接口为：
```
url接口：baidumap://map/navi
```
需要传递的参数有

|参数名称|描述|是否必选|格式(示例)|
|---|---|---|---|
|location|坐标点，location与query二者必须有一个，当有location时，忽略query；坐标类型参考通用参数：coord_type|可选|经纬度：39.9761,116.3282|
|query|搜索key，llocation与query二者必须有一个，当有location时，忽略query；坐标类型参考通用参数：coord_type|可选|故宫|
|type|路线规划类型，BLK: 躲避拥堵(自驾);TIME: 高速优先(自驾);DIS: 不走高速(自驾);FEE: 少收费(自驾); DEFAULT: 不选择偏好；空或者无此字段：使用地图中已保存的路线偏好(缺省值)。|可选||
|src|统计来源|必选|参数格式为：andr.companyName.appName 不传此参数，不保证服务|

官方文档代码使用示例
```
Intent i1 = new Intent();
// 驾车导航
i1.setData(Uri.parse("baidumap://map/navi?query=故宫&src=andr.baidu.openAPIdemo"));
startActivity(i1);
```
上面是百度文档的描述，但是我查看网上的代码，有些没有规定的参数也可以传。我使用跳转百度地图的方法如下
```Java
class AClass{
    /**
     * 跳转百度地图
     */
    private void goToBaiduMap() {
        if (!isInstalled("com.baidu.BaiduMap")) {
            T.show(mContext, "请先安装百度地图客户端");
            return;
        }
        Intent intent = new Intent();
        intent.setData(Uri.parse("baidumap://map/direction?destination=latlng:"
                + mLat + ","
                + mLng + "|name:" + mAddressStr + // 终点
                "&mode=driving" + // 导航路线方式
                "&src=" + getPackageName()));
        startActivity(intent); // 启动调用
    }
}
```

##### 2.2.2 高德地图
官方文档代码使用示例
```
cat=android.intent.category.DEFAULT
dat=androidamap://navi?sourceApplication=appname&poiname=fangheng&lat=36.547901&lon=104.258354&dev=1&style=2
pkg=com.autonavi.minimap
```

参数说明

|参数|说明|是否必填|
|---|---|---|
|navi|服务类型|是|
|sourceApplication|第三方调用应用名称。如 amap|是|
|poiname|POI名称|否|
|lat|纬度|是|
|lon|经度|是|
|dev|是否偏移(0:lat 和 lon 是已经加密后的,不需要国测加密; 1:需要国测加密)|是|
|style|	导航方式(0 速度快; 1 费用少; 2 路程短; 3 不走高速；4 躲避拥堵；5 不走高速且避免收费；6 不走高速且躲避拥堵；7 躲避收费和拥堵；8 不走高速躲避收费和拥堵)|是|

跳转高德地图导航
```java
class AClass{
    /**
     * 跳转高德地图
     */
    private void goToGaodeMap() {
        if (!isInstalled("com.autonavi.minimap")) {
            T.show(mContext, "请先安装高德地图客户端");
            return;
        }
        LatLng endPoint = BD2GCJ(new LatLng(mLat, mLng));//坐标转换
        StringBuffer stringBuffer = new StringBuffer("androidamap://navi?sourceApplication=").append("amap");
         stringBuffer.append("&lat=").append(endPoint.latitude)
                .append("&lon=").append(endPoint.longitude).append("&keywords=" + mAddressStr)
                .append("&dev=").append(0)
                .append("&style=").append(2);
        Intent intent = new Intent("android.intent.action.VIEW", Uri.parse(stringBuffer.toString()));
        intent.setPackage("com.autonavi.minimap");
        intent.addCategory(Intent.CATEGORY_DEFAULT);
        startActivity(intent);
    }
}
```

##### 2.2.3 腾讯地图
Android 和 iOS 调用地址：
```
qqmap://map/routeplan
```
官方文档代码使用示例
```
//调起腾讯地图APP，显示由清华大学到怡和世家小区的驾车路线 
qqmap://map/routeplan?type=drive&from=清华&fromcoord=39.994745,116.247282&to=怡和世家&tocoord=39.867192,116.493187&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77
```

参数说明

|参数|必填|说明|示例|
|---|---|---|---|
|type|是|	路线规划方式参数：<br>公交：bus <br>驾车：drive<br> 步行：walk<br> 骑行：bike|type=bus 或 type=drive 或 type=walk 或 type=bike|
|from|否|起点名称|from=鼓楼|
|fromcoord|是|起点坐标，格式：lat,lng （纬度在前，经度在后，逗号分隔） <br>功能参数值：CurrentLocation ：使用定位点作为起点坐标|fromcoord=39.907380,116.388501 <br> fromcoord=CurrentLocation|
|to|否|终点名称|to=奥林匹克森林公园|
|tocoord|是|终点坐标|	tocoord=40.010024,116.392239|
|referer|是|请填写开发者key([点此申请](http://lbs.qq.com/console/key.html))|referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77|

据说只传type和tocoord就可以，它会默认定位起点为你当前位置
```java
class ACLass{
    /**
     * 跳转腾讯地图
     */
    private void goToTencentMap() {
        if (!isInstalled("com.tencent.map")) {
            T.show(mContext, "请先安装腾讯地图客户端");
            return;
        }
        LatLng endPoint = BD2GCJ(new LatLng(mLat, mLng));//坐标转换
          StringBuffer stringBuffer = new StringBuffer("qqmap://map/routeplan?type=drive")
                .append("&tocoord=").append(endPoint.latitude).append(",").append(endPoint.longitude).append("&to=" + mAddressStr);
        Intent intent = new Intent("android.intent.action.VIEW", Uri.parse(stringBuffer.toString()));
        startActivity(intent);
    }
}
```

### 3、总结
调用第三方地图导航，要先搞清楚自己使用的是那，种坐标系，如果坐标系不正确，位置导航会有偏差。

copy from https://blog.csdn.net/ever69/article/details/82427085