# Android WebView 注入css

## 方式一： 在loadurl时注入

在loadurl时，获取到需要加载的html内容，将css内容拼接到html中

操作在加载时进行

## 方式二： 在页面加载完后，将css拼接成js方法加载

可能会导致页面闪烁，可尝试使用动画优化视觉效果

```kotlin
/**
 * WebViewInjectUtil.kt
 * 参考
 * https://stackoverflow.com/questions/30018540/inject-css-to-a-site-with-webview-in-android
 * https://www.jianshu.com/p/08036fc1d4d0
 */

/**
 * 通过loadurl，将assets中的css加载到html中
 */
fun WebView.loadUrlWithCssAsset(url: String, assetsCssPath: String) {
    val css = WebViewInjectUtil.buildCss(context, assetsCssPath)
    loadUrlWithCss(url, css)
}

/**
 * 通过loadurl，将css文本加载到html中
 */
fun WebView.loadUrlWithCss(url: String, cssStr: String) {
    val job = GlobalScope.launch(Dispatchers.IO) {
        val page = WebViewInjectUtil.getHtmlByUrl(url)
        val wrapperCss = "<style>" + cssStr.trim { it <= ' ' }.replace("\n", "") + "</style>"
        val pageAfterInject = WebViewInjectUtil.injectCss(page, wrapperCss)
        withContext(Dispatchers.Main) {
            loadDataWithBaseURL(url, pageAfterInject, null, WebViewInjectUtil.defaultEncoding, null)
        }
    }
    addOnAttachStateChangeListener(object : View.OnAttachStateChangeListener {
        override fun onViewAttachedToWindow(v: View?) {
        }

        override fun onViewDetachedFromWindow(v: View?) {
            job.cancel()
        }
    })

}

/**
 * 将assets中的css文件拼接为js代码load到页面
 * 在页面加载完成调用
 */
fun injectCssAsset(webview: WebView, assetsCssPath: String) {
    val inputStream = webview.context.assets.open(assetsCssPath)
    val buffer = ByteArray(inputStream.available())
    inputStream.read(buffer)
    inputStream.close()
    val encodedCssStr = Base64.encodeToString(buffer, Base64.NO_WRAP)
    injectCss(webview, encodedCssStr, false)
}

/**
 * 将css文件拼接为js代码load到页面
 * 在页面加载完成调用
 */
fun injectCss(webview: WebView, cssString: String, needEncode: Boolean = true) {
    val cssStr = if (needEncode) stringToBase64(cssString) else cssString
    val styleCss = """
        javascript:
            !(function() {
                var parent = document.getElementsByTagName('head').item(0);
                var style = document.createElement('style');
                style.type = 'text/css';
                style.innerHTML = window.atob('${cssStr}');
                parent.appendChild(style)
            })()
        """.trimIndent()
    webview.loadUrl(styleCss)
}
/*
Improve UX with a smooth transition to show webview
fun View.smoothShow() {
    alpha = 0f
    visibility = View.VISIBLE

    animate()
        .alpha(1f)
        .setDuration(300)
        .setListener(null)
}

viewDataBinding.wv.webViewClient = object : WebViewClient() {
    override fun onPageCommitVisible(view: WebView?, url: String?) {
        applyContentWithCSS()
        super.onPageCommitVisible(view, url)
    }

    override fun onPageFinished(view: WebView?, url: String?) {
        applyContentWithCSS()
        //Only show when load complete
        if (viewDataBinding.wvContent.progress == 100) {
            viewDataBinding.wvContent.smoothShow()
        }
        super.onPageFinished(view, url)
    }
}
*/

object WebViewInjectUtil {

    var defaultEncoding = Charsets.UTF_8.name()

    /**
     * Concatenates CSS rules to given page content
     *
     * @return Concatenation result
     */
    fun injectCss(pageContentStr: String, css: String): String {
        val headEnd = pageContentStr.indexOf("</head>")
        val res = if (headEnd > 0) {
            pageContentStr.substring(0, headEnd) + css + pageContentStr.substring(headEnd, pageContentStr.length)
        } else {
            "<head>$css</head>$pageContentStr"
        }
        return res
    }

    /**
     * Fetches url content and returns it as string
     */
    @UiThread
    internal fun getHtmlByUrl(webUrl: String?): String {
        val total = StringBuilder()
        try {
            val url = URL(webUrl)
            val connection = url.openConnection() as HttpURLConnection
            val `is` = connection.inputStream
            var encoding = connection.contentEncoding
            if (encoding == null) {
                encoding = defaultEncoding
            }
            val r = BufferedReader(InputStreamReader(`is`, encoding))
            var line: String?
            while (r.readLine().also { line = it } != null) {
                total.append(line)
            }
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return total.toString()
    }

    /**
     * Read CSS file from assets
     *
     * @return String with the format '<style> xxxx </style>'
     */
    internal fun buildCss(context: Context, assetsCssPath: String): String {
        val contents = StringBuilder()
        val reader: InputStreamReader
        try {
            reader = InputStreamReader(context.assets.open(assetsCssPath), defaultEncoding)
            val br = BufferedReader(reader)
            var line: String?
            while (br.readLine().also { line = it } != null) {
                contents.append(line)
            }
        } catch (e: UnsupportedEncodingException) {
            e.printStackTrace()
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return contents.toString()
    }
}

fun stringToBase64(input: String): String {
    val inputStream: InputStream = ByteArrayInputStream(input.toByteArray(StandardCharsets.UTF_8))
    val buffer = ByteArray(inputStream.available())
    inputStream.read(buffer)
    inputStream.close()
    return Base64.encodeToString(buffer, Base64.NO_WRAP)
}
```
