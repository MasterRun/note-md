# Android工具类封装---Toast
```Java
public class ToastUtil {

    /**
     * Toast对象集合
     * 一个activity对象对应一个toast对象
     */
    private static Map<String, Toast> toastMap = new HashMap<>();
    
    /**
     * 上次toast显示所在的activity
     */
    private static String lastActivity = "";

    /**
     * 显示Toast
     *
     * @param message
     */
    private static void showToast(final String message, final int duration) {
        //获取当前显示的activity
        Activity stackTopActivity = AppUtil.getApplication().getStackTopActivity();
        final String activityInstanceStr = stackTopActivity.toString();
        stackTopActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                //如果和上次不是同一activity,取消所有toast的显示
                if (!TextUtils.equals(activityInstanceStr, lastActivity)) {
                    lastActivity = activityInstanceStr;
                    for (Map.Entry<String, Toast> stringToastEntry : toastMap.entrySet()) {
                        stringToastEntry.getValue().cancel();
                    }
                }
                //获取toast
                Toast toast = toastMap.get(activityInstanceStr);
                if (toast == null) {
                    //创建toast对象,对应activity,但是还是使用applicationContext创建
                    toast = Toast.makeText(AppUtil.getApplication(), message, duration);
                    toastMap.put(activityInstanceStr, toast);
                } else {
                    //设置文本内容
                    toast.setText(message);
                }
                //设置时长
                toast.setDuration(duration);
                //显示toast
                toast.show();
            }
        });
    }

    /**
     * 显示短时长的toast
     *
     * @param message 显示内容
     */
    public static void toastShort(String message) {
        showToast(message, Toast.LENGTH_SHORT);
    }

    /**
     * 显示长时长的toast
     *
     * @param message 显示内容
     */
    public static void toastLong(String message) {
        showToast(message, Toast.LENGTH_LONG);
    }
}
```