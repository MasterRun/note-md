# Arcgis100 Android地图加载
### 1、导入arcgis依赖
在项目的build.gradle中添加maven库：
``` gradle
maven { url 'https://esri.bintray.com/arcgis' }
```
在module的build.gradle中添加依赖：
``` gradle
implementation 'com.esri.arcgisruntime:arcgis-android:100.5.0'
```
在android闭包中添加Java编译选项：
``` gradle
compileOptions {
    sourceCompatibility JavaVersion.VERSION_1_8
    targetCompatibility JavaVersion.VERSION_1_8
}
```
点击Sync同步项目
### 2、添加权限
在AndroidManifest.xml中添加相关权限并开启opengles
```xml
<manifest>
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	<uses-permission android:name="android.permission.INTERNET" />
	<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
		
	<uses-feature
		android:glEsVersion="0x00020000"
		android:required="true" />
</manifest>
```
### 3、加载地图
在布局文件中添加MapView
```xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
	xmlns:app="http://schemas.android.com/apk/res-auto"
	xmlns:tools="http://schemas.android.com/tools"
	android:layout_width="match_parent"
	android:layout_height="match_parent"
	tools:context=".view.ArcgisDemoActivity">
	
	<com.esri.arcgisruntime.mapping.view.MapView
		android:id="@+id/mapview"
		android:layout_width="0dp"
		android:layout_height="0dp"
		app:layout_constraintBottom_toBottomOf="parent"
		app:layout_constraintLeft_toLeftOf="parent"
		app:layout_constraintRight_toRightOf="parent"
		app:layout_constraintTop_toTopOf="parent" />
</android.support.constraint.ConstraintLayout>
```
加载地图
```kotlin
class ArcgisDemoActivity : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)

        setupMap()
    }
    
    
    private fun setupMap() {
        mapview?.let {

            val baseMapType = Basemap.Type.STREETS_VECTOR
            val latitude = 34.09042//31.896261
            val longitude = -118.71511//120.573642
            val levelOfDetail = 15
            val map = ArcGISMap(baseMapType, latitude, longitude, levelOfDetail)
            it.map = map
//            addLayer(map)
        }
    }
    
    //以下方法添加图层
    private fun addLayer(map: ArcGISMap) {

        val itemId = "2e4b3df6ba4b44969a3bc9827de746b3"
        val portal = Portal("http://www.arcgis.com")
        val portalItem = PortalItem(portal, itemId)
        val featureLayer = FeatureLayer(portalItem, 0)
        featureLayer.addDoneLoadingListener {
            if (featureLayer.loadStatus == LoadStatus.LOADED) {
                map.operationalLayers.add(featureLayer)
            }
        }
        featureLayer.loadAsync()
    }
}
```

另对应在activity生命周期中同步mapview的生命周期

同时可以使用PortalItem对象构造ArcGISMap对象直接加载地图