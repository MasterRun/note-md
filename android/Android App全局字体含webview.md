# Android App全局字体含webview

## 1.替换APP原生view字体

```java
public class TypefaceUtils {
    /**
     * 为给定的字符串添加HTML红色标记，当使用Html.fromHtml()方式显示到TextView 的时候其将是红色的
     *
     * @param string 给定的字符串
     * @return
     */
    public static String addHtmlRedFlag(String string) {
        return "<font color=\"red\">" + string + "</font>";
    }

    /**
     * 将给定的字符串中所有给定的关键字标红
     *
     * @param sourceString 给定的字符串
     * @param keyword      给定的关键字
     * @return 返回的是带Html标签的字符串，在使用时要通过Html.fromHtml()转换为Spanned对象再传递给TextView对象
     */
    public static String keywordMadeRed(String sourceString, String keyword) {
        String result = "";
        if (sourceString != null && !"".equals(sourceString.trim())) {
            if (keyword != null && !"".equals(keyword.trim())) {
                result = sourceString.replaceAll(keyword, "<font color=\"red\">" + keyword + "</font>");
            } else {
                result = sourceString;
            }
        }
        return result;
    }

    /**
     * <p>Replace the font of specified view and it's children</p>
     *
     * @param root     The root view.
     * @param fontPath font file path relative to 'assets' directory.
     */
    public static void replaceFont(@NonNull View root, String fontPath) {
        if (root == null || TextUtils.isEmpty(fontPath)) {
            return;
        }

        if (root instanceof TextView) { // If view is TextView or it's subclass, replace it's font
            TextView textView = (TextView) root;
            int style = Typeface.NORMAL;
            if (textView.getTypeface() != null) {
                style = textView.getTypeface().getStyle();
            }
            textView.setTypeface(createTypeface(root.getContext(), fontPath), style);
        } else if (root instanceof ViewGroup) { // If view is ViewGroup, apply this method on it's child views
            ViewGroup viewGroup = (ViewGroup) root;
            for (int i = 0; i < viewGroup.getChildCount(); ++i) {
                replaceFont(viewGroup.getChildAt(i), fontPath);
            }
        }
    }

    /**
     * <p>Replace the font of specified view and it's children</p>
     * 通过递归批量替换某个View及其子View的字体改变Activity内部控件的字体(TextView,Button,EditText,CheckBox,RadioButton等)
     *
     * @param context  The view corresponding to the activity.
     * @param fontPath font file path relative to 'assets' directory.
     */
    public static void replaceFont(@NonNull Activity context, String fontPath) {
        replaceFont(getRootView(context), fontPath);
    }


    /*
     * Create a Typeface instance with your font file
     */
    public static Typeface createTypeface(Context context, String fontPath) {
        return Typeface.createFromAsset(context.getAssets(), fontPath);
    }

    /**
     * 从Activity 获取 rootView 根节点
     *
     * @return 当前activity布局的根节点
     */
    public static View getRootView(Activity context) {
        return ((ViewGroup) context.findViewById(android.R.id.content)).getChildAt(0);
    }

    /**
     * 通过改变App的系统字体替换App内部所有控件的字体(TextView,Button,EditText,CheckBox,RadioButton等)
     */
//    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
//    <!-- Customize your theme here. -->
//    <!-- Set system default typeface -->
//    <item name="android:typeface">monospace</item>
//    </style>
    public static void replaceSystemDefaultFont(@NonNull Context context, @NonNull String fontPath) {
        Typeface typeface = createTypeface(context, fontPath);
        replaceTypefaceField("DEFAULT", typeface);
        replaceTypefaceField("DEFAULT_BOLD", typeface);
        replaceTypefaceField("SANS_SERIF", typeface);
        replaceTypefaceField("SERIF", typeface);
        replaceTypefaceField("MONOSPACE", typeface);
        replaceTypefaceDefaults(typeface);
    }


    private static void replaceTypefaceDefaults(Typeface typeface) {
        try {
            Field defaultField = Typeface.class.getDeclaredField("sDefaults");
            defaultField.setAccessible(true);
            Typeface[] typefaces = (Typeface[]) defaultField.get(null);
            for (int i = 0; i < typefaces.length; i++) {
                typefaces[i] = typeface;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * <p>Replace field in class Typeface with reflection.</p>
     */
    private static void replaceTypefaceField(String fieldName, Object value) {
        try {
            Field defaultField = Typeface.class.getDeclaredField(fieldName);
            defaultField.setAccessible(true);
            defaultField.set(null, value);
        } catch (NoSuchFieldException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
```

！！主要关注最后3个方法，其他设置view及activity字体的方法需要注意使用时机

1. 将字体放入assets，例如 `assets/font/MyCustomFont.ttf`
2. 使用上方的工具类，在application的onCreate方法中调用`TypefaceUtils.replaceSystemDefaultFont(getApplication(),"font/MyCustomFont.ttf");`
3. 将application的theme中的`android:typeface`值设置为`monospace`(只要设置的值在`replaceSystemDefaultFont`方法的覆盖范围内即可)

## 2.更改webview页面字体

1. 在`WebViewClient#onPageFinished`方法中注入js方法设置h5页面字体

   ```java
   public void onPageFinished(WebView webview, String url) {
       view.loadUrl("javascript:!function(){" +
                    "s=document.createElement('style');" +
                    "s.innerHTML=\"@font-face{font-family:MyFont;src:url('****/fonts/MyCustomFont.ttf');} *{font-family:MyFont !important;}\";" +
                    "document.getElementsByTagName('head')[0].appendChild(s);" +
                    "document.getElementsByTagName('body')[0].style.fontFamily = \"MyFont\";" +
                    "}()");
        super.onPageFinished(view, url);
   }
   ```

2. 在`WebViewClient#shouldInterceptRequest`方法中拦截字体，改为assets中的字体

   ```java
        @Nullable
        @Override
        public WebResourceResponse shouldInterceptRequest(WebView view, String url) {
            WebResourceResponse response = super.shouldInterceptRequest(view, url);
            if (url != null && url.contains("MyCustomFont.ttf")) {
                String assetsPath = "font/MyCustomFont.ttf";
                try {
                    response = new WebResourceResponse("application/x-font-ttf", "UTF8", view.getContext().getAssets().open(assetsPath));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return response;
        }
   ```
