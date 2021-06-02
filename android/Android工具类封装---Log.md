# Android工具类封装---Log

```kotlin
object LogcatUtil {
    /**
     * 控制是否开启日志
     */
    var openLog = true

    /**
     * APP是否是debug版
     */
    var isDebug = openLog

    internal var gson = Gson()

    val simpleName = LogcatUtil::class.java.simpleName

    /**
     * 得到tag  (ClazzName.java)/ThreadName
     *
     * @return
     */
    private fun generateTag(): String {
        var index = 2
        var callerClazzName = ""
        val thread = Thread.currentThread()
        val stackTraces = thread.stackTrace
        var stackTraceElement: StackTraceElement
        do {
            stackTraceElement = stackTraces[index]
            callerClazzName = stackTraceElement.className
            callerClazzName = callerClazzName.substring(callerClazzName.lastIndexOf(".") + 1)
            index++
        } while (callerClazzName.startsWith(simpleName))
        var tag = "(%s:%s)/%s"
        val name = thread.name
        tag = String.format(
            Locale.CHINA,
            tag,
            stackTraceElement.fileName,
            stackTraceElement.lineNumber,
            name
        )
        return tag
    }

    //region verbose级别的日志
    fun v_json(jsonStr: String) {
        val s = formatJsonStr(jsonStr)
        val lines = s.lines()
        for (line in lines) {
            v(msg = line)
        }
    }

    fun v(`object`: Any?) {
        if (`object` != null) {
            v_json(tryConvertString(`object`))
        }
    }

    /**
     * 打印 verbose 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    @JvmOverloads
    @JvmStatic
    fun v(msg: String?, tr: Throwable? = null) {
        v(tag = null, msg = msg, tr = tr)
    }

    @JvmStatic
    fun v(tag: String? = null, msg: String? = null, tr: Throwable? = null) {
        var tag = tag
        var msg = msg
        if (openLog && isDebug) {
            if (msg == null) {
                msg = ""
            }
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag()
            }
            if (tr == null) {
                Log.v(tag, msg)
            } else {
                Log.v(tag, msg, tr)
            }
        }
    }
    //endregion
    //region debug级别的日志

    fun d_json(jsonStr: String) {
        val s = formatJsonStr(jsonStr)
        val lines = s.lines()
        for (line in lines) {
            d(msg = line)
        }
    }

    fun d(`object`: Any?) {
        if (`object` != null) {
            d_json(tryConvertString(`object`))
        }
    }

    /**
     * 打印 debug 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    @JvmOverloads
    @JvmStatic
    fun d(msg: String?, tr: Throwable? = null) {
        d(tag = null, msg = msg, tr = tr)
    }

    @JvmStatic
    fun d(tag: String? = null, msg: String? = null, tr: Throwable? = null) {
        var tag = tag
        var msg = msg
        if (openLog && isDebug) {
            if (msg == null) {
                msg = ""
            }
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag()
            }
            if (tr == null) {
                Log.d(tag, msg)
            } else {
                Log.d(tag, msg, tr)
            }
        }
    }
    //endregion
    //region info级别的日志

    fun i_json(jsonStr: String) {
        val s = formatJsonStr(jsonStr)
        val lines = s.lines()
        for (line in lines) {
            i(msg = line)
        }
    }

    fun i(`object`: Any?) {
        if (`object` != null) {
            i_json(tryConvertString(`object`))
        }
    }

    /**
     * 打印 info 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    @JvmOverloads
    @JvmStatic
    fun i(msg: String?, tr: Throwable? = null) {
        i(tag = null, msg = msg, tr = tr)
    }

    @JvmStatic
    fun i(tag: String? = null, msg: String? = null, tr: Throwable? = null) {
        var tag = tag
        var msg = msg
        if (openLog && isDebug) {
            if (msg == null) {
                msg = ""
            }
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag()
            }
            if (tr == null) {
                Log.i(tag, msg)
            } else {
                Log.i(tag, msg, tr)
            }
        }
    }

    //endregion
    //region warn级别的日志
    fun w_json(jsonStr: String) {
        val s = formatJsonStr(jsonStr)
        val lines = s.lines()
        for (line in lines) {
            w(msg = line)
        }
    }

    fun w(`object`: Any?) {
        if (`object` != null) {
            w_json(tryConvertString(`object`))
        }
    }

    /**
     * 打印 warn 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    @JvmOverloads
    @JvmStatic
    fun w(msg: String?, tr: Throwable? = null) {
        w(tag = null, msg = msg, tr = tr)
    }

    @JvmStatic
    fun w(tag: String? = null, msg: String?, tr: Throwable? = null) {
        var tag = tag
        var msg = msg
        if (openLog && isDebug) {
            if (msg == null) {
                msg = ""
            }
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag()
            }
            if (tr == null) {
                Log.w(tag, msg)
            } else {
                Log.w(tag, msg, tr)
            }
        }
    }

    //endregion
    //region error 级别的日志
    fun e_json(jsonStr: String) {
        val s = formatJsonStr(jsonStr)
        val lines = s.lines()
        for (line in lines) {
            e(msg = line)
        }
    }

    fun e(`object`: Any?) {
        if (`object` != null) {
            e_json(tryConvertString(`object`))
        }
    }

    /**
     * 打印 error 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    @JvmOverloads
    @JvmStatic
    fun e(msg: String?, tr: Throwable? = null) {
        e(tag = null, msg = msg, tr = tr)
    }

    @JvmStatic
    fun e(tag: String? = null, msg: String?, tr: Throwable? = null) {
        var tag = tag
        var msg = msg
        if (openLog && isDebug) {
            if (msg == null) {
                msg = ""
            }
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag()
            }
            if (tr == null) {
                Log.e(tag, msg)
            } else {
                Log.e(tag, msg, tr)
            }
        }
    }

    //endregion
    fun tryConvertString(`object`: Any?): String {
        if (`object` == null) {
            return ""
        }
        if (`object` is CharSequence) {
            return `object`.toString()
        }
        var str = ""
        try {
            str = gson.toJson(`object`)
        } catch (e: Exception) {
            e.printStackTrace()
            str = `object`.toString()
        }
        return str
    }

    fun formatJsonStr(str: String): String {
        var formatStr = str
        try {
            val jsonTokener = JSONTokener(str)
            val `object` = jsonTokener.nextValue()
            if (`object` is JSONArray) {
                formatStr = `object`.toString(1)
            } else if (`object` is JSONObject) {
                formatStr = `object`.toString(1)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return formatStr
    }
}

fun Any?.v() = LogcatUtil.v(this)
fun String?.v() = LogcatUtil.v(msg = this)
fun Any?.d() = LogcatUtil.d(this)
fun String?.d() = LogcatUtil.d(msg = this)
fun Any?.i() = LogcatUtil.i(this)
fun String?.i() = LogcatUtil.i(msg = this)
fun Any?.w() = LogcatUtil.w(this)
fun String?.w() = LogcatUtil.w(msg = this)
fun Any?.e() = LogcatUtil.e(this)
fun String?.e() = LogcatUtil.e(msg = this)
```

```java
public class LogcatUtil {

    /**
     * 控制是否开启日志
     */
    private static boolean openLog = true;

    /**
     * 控制是否开启日志
     * <p>
     * 说明:不论是否开启,在release模式下都不会打印
     *
     * @param openLog
     */
    public static void setOpenLog(boolean openLog) {
        LogcatUtil.openLog = openLog;
    }

    /**
     * 得到tag  (ClazzName.java)/ThreadName
     *
     * @return
     */
    private static String generateTag() {
        int index = 3;
        String callerClazzName = "";
        Thread thread = Thread.currentThread();
        StackTraceElement[] stackTraces = thread.getStackTrace();
        StackTraceElement stackTraceElement;
        do {
            stackTraceElement = stackTraces[index];
            callerClazzName = stackTraceElement.getClassName();
            callerClazzName = callerClazzName.substring(callerClazzName.lastIndexOf(".") + 1);
            index++;
        } while (TextUtils.equals(LogcatUtil.class.getSimpleName(), callerClazzName));
        String tag = "(%s:%s)/%s";
        String name = thread.getName();
        tag = String.format(Locale.CHINA, tag, stackTraceElement.getFileName(), stackTraceElement.getLineNumber(), name);
        return tag;
    }

    //region verbose级别的日志

    /**
     * 打印 verbose 级别的日志
     *
     * @param msg 日志信息
     */
    public static void v(String msg) {
        v("", msg);
    }

    /**
     * 打印 verbose 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     */
    public static void v(String tag, String msg) {
        v(tag, msg, null);
    }

    /**
     * 打印 verbose 级别的日志
     *
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void v(String msg, Throwable tr) {
        v("", msg, tr);
    }

    /**
     * 打印 verbose 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void v(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG && openLog) {
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag();
            }
            if (tr == null) {
                Log.v(tag, msg);
            } else {
                Log.v(tag, msg, tr);
            }
        }
    }
    //endregion

    //region debug级别的日志

    /**
     * 打印
     * debug 级别的日志
     *
     * @param msg 日志信息
     */
    public static void d(String msg) {
        d("", msg);
    }

    /**
     * 打印 debug 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     */
    public static void d(String tag, String msg) {
        d(tag, msg, null);
    }

    /**
     * 打印 debug 级别的日志
     *
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void d(String msg, Throwable tr) {
        d("", msg, tr);
    }

    /**
     * 打印 debug 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void d(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG && openLog) {
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag();
            }
            if (tr == null) {
                Log.d(tag, msg);
            } else {
                Log.d(tag, msg, tr);
            }
        }
    }
    //endregion

    //region info级别的日志

    /**
     * 打印 info 级别的日志
     *
     * @param msg 日志信息
     */
    public static void i(String msg) {
        i("", msg);
    }

    /**
     * 打印 info 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     */
    public static void i(String tag, String msg) {
        i(tag, msg, null);
    }

    /**
     * 打印 info 级别的日志
     *
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void i(String msg, Throwable tr) {
        i("", msg, tr);
    }

    /**
     * 打印 info 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void i(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG && openLog) {
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag();
            }
            if (tr == null) {
                Log.i(tag, msg);
            } else {
                Log.i(tag, msg, tr);
            }
        }
    }
    //endregion

    //region warn级别的日志

    /**
     * 打印 warn 级别的日志
     *
     * @param msg 日志信息
     */
    public static void w(String msg) {
        w("", msg);
    }

    /**
     * 打印 warn 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     */
    public static void w(String tag, String msg) {
        w(tag, msg, null);
    }

    /**
     * 打印 warn 级别的日志
     *
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void w(String msg, Throwable tr) {
        w("", msg, tr);
    }

    /**
     * 打印 warn 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void w(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG && openLog) {
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag();
            }
            if (tr == null) {
                Log.w(tag, msg);
            } else {
                Log.w(tag, msg, tr);
            }
        }
    }
    //endregion

    //region error 级别的日志

    /**
     * 打印 error 级别的日志
     *
     * @param msg 日志信息
     */
    public static void e(String msg) {
        e("", msg);
    }

    /**
     * 打印 error 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     */
    public static void e(String tag, String msg) {
        e(tag, msg, null);
    }

    /**
     * 打印 error 级别的日志
     *
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void e(String msg, Throwable tr) {
        e("", msg, null);
    }

    /**
     * 打印 error 级别的日志
     *
     * @param tag tag
     * @param msg 日志信息
     * @param tr  throwable对象
     */
    public static void e(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG && openLog) {
            if (TextUtils.isEmpty(tag)) {
                tag = generateTag();
            }
            if (tr == null) {
                Log.e(tag, msg);
            } else {
                Log.e(tag, msg, tr);
            }
        }
    }
    //endregion

}
```