# Arcgis10 Android地图加载
### 1、导入arcgis依赖
在项目的build.gradle中添加maven库：
``` gradle
maven { url 'https://esri.bintray.com/arcgis' }
```
在module的build.gradle中添加依赖：
``` gradle
implementation 'com.esri.arcgis.android:arcgis-android:10.2.9'
```
在android闭包中添加：
``` gradle
//arcgis 创建的Android软件包（APK）文件中排除重复文件，从而防止构建错误。
packagingOptions {
    exclude 'META-INF/LGPL2.1'
    exclude 'META-INF/LICENSE'
    exclude 'META-INF/NOTICE'
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
### 3、使用MapView加载地图
在布局文件中添加MapView
```xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
	xmlns:app="http://schemas.android.com/apk/res-auto"
	xmlns:tools="http://schemas.android.com/tools"
	android:layout_width="match_parent"
	android:layout_height="match_parent"
	tools:context=".view.ArcgisDemoActivity">
	
	<com.esri.android.map.MapView
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

        val gisTiledMapServiceLayer2 =
            ArcGISTiledMapServiceLayer("your map online url")
        mapview.addLayer(gisTiledMapServiceLayer2)
    }

}
```
### 附件：完整加载流程
```kotlin

class ArcgisDemoActivity : BaseActivity() {

    var mapscale = 5000.0
    var markPoint: Point? = null
    var clickPoint: Point? = null
    var graphicsLayer: GraphicsLayer? = null
    var locationDisplayManager: LocationDisplayManager? = null

    override var mainLayoutId = R.layout.activity_arcgis_demo
    override var useContainer2: Boolean = true

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        topbar.setTitle("Arcgis")
        smart_refresh_layout.isEnabled = false
        setSwipeBackEnable(false)

        //授权，去除arcgis水印
        ArcGISRuntime.setClientId("xxx")
        val creds = UserCredentials()
        //账密
        creds.setUserAccount("account", "password")
        //tokenurl
        creds.tokenServiceUrl = "tokne url"

        //地图加载地址
        val gisTiledMapServiceLayer = ArcGISTiledMapServiceLayer(
            "mapsever url",
            creds
        )
        mapview.addLayer(gisTiledMapServiceLayer)

//        val gisTiledMapServiceLayer2 =
//            ArcGISTiledMapServiceLayer("mapsever url")
//        mapview.addLayer(gisTiledMapServiceLayer2)
        //这这个图层用于添加标记
        graphicsLayer = GraphicsLayer()

        mapview.addLayer(graphicsLayer)

        mapview.setOnTouchListener(MyTouchListener(this, mapview))

        //延迟加载
        mapview.setOnStatusChangedListener { any, status ->
            if (any == mapview && status == OnStatusChangedListener.STATUS.INITIALIZED) {
                mapview.postDelayed({
                    mapview.visibility = View.VISIBLE
                    //自动定位
                    setupLocationListener()
                }, 500L)
            }
        }
    }

    private fun setupLocationListener() {
        mapview?.let {
            if (it.isLoaded) {
                locationDisplayManager = it.locationDisplayManager
                locationDisplayManager?.locationListener = object : LocationListener {
                    override fun onLocationChanged(location: Location?) {
                        location?.let {
                            L.i("定位：x: ${it.longitude},y: {${it.latitude}")

                            clickPoint = getAsPoint(location)
                            zoomToPoint(clickPoint!!, R.drawable.cgt_target_red)

                            //设置定位模式
                            locationDisplayManager?.autoPanMode =
                                LocationDisplayManager.AutoPanMode.LOCATION
                            //关闭定位
//                        locationDisplayManager?.stop()
                        }
                    }

                    override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {
                    }

                    override fun onProviderEnabled(provider: String?) {
                    }

                    override fun onProviderDisabled(provider: String?) {
                    }
                }
                //开始定位
                locationDisplayManager?.start()
            }
        }
    }

    // 缩放到指定位置
    fun zoomToPoint(point: Point, imgid: Int) {
        graphicsLayer?.removeAll()
        mapview?.let {
            // 在地图上标注位置
            val pictureFillSymbol =
                PictureMarkerSymbol(it.getContext(), resources.getDrawable(imgid))
            val graphic = Graphic(point, pictureFillSymbol)
            graphicsLayer?.addGraphic(graphic)

            // 缩放到位置点
            it.zoomToScale(point, mapscale)
        }
    }

    // GPS坐标 转 Point
    private fun getAsPoint(loc: Location): Point? {
        mapview?.let {
            val wgsPoint = Point(loc.longitude, loc.latitude)
            return GeometryEngine.project(
                wgsPoint,
                it.spatialReference,
                it.spatialReference
            ) as Point
        }
        return null
    }

    inner class MyTouchListener(context: Context, mapview: MapView) :
        MapOnTouchListener(context, mapview) {
        override fun onSingleTap(point: MotionEvent?): Boolean {
            L.d("当前地图比例：${mapview.scale}")
            return true
        }

        //长按缩放
        override fun onLongPress(event: MotionEvent?) {
            super.onLongPress(event)
            event?.apply {
                L.d("long press x:${x},y:${y}")
                markPoint = mapview.toMapPoint(x, y)
                zoomToPoint(markPoint!!, R.drawable.cgt_target_red)
            }

        }
    }

    override fun onResume() {
        super.onResume()
        mapview?.postDelayed({
            mapview?.apply {
                unpause()
            }
        }, 500)
    }

    override fun onPause() {
        super.onPause()
        mapview?.apply {
            pause()
        }
    }

    override fun onDestroy() {
        mapview?.apply {
            destroyDrawingCache()
            recycle()
        }
        super.onDestroy()
    }
}
```