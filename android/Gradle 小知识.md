# Gradle dsl 文档

https://docs.gradle.org/current/dsl/

# setting.gradle

includeBuild()
可以将整个项目包含构建，但是依赖可能有问题

# build.gradle

``` groovy
    dependencies {
        classpath 'com.android.tools.build:gradle:3.5.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.sensorsdata.analytics.android:android-gradle-plugin2:3.2.10'
        classpath 'org.greenrobot:greendao-gradle-plugin:3.3.0'
        classpath 'com.meituan.android.walle:plugin:1.1.7'

        //在dependenmcies中指定module进行配置
        module(":mall", {
            classpath "com.android.tools.build:gradle:7.0.0"
            classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.5.10"
        })
        module(":app", {
            classpath 'com.android.tools.build:gradle:3.5.2'
            classpath 'com.huawei.agconnect:agcp:1.3.1.300'
            classpath "com.alibaba:arouter-register:1.0.2"
            // tinkersupport插件(1.0.3以上无须再配置tinker插件）
            classpath "com.tencent.bugly:tinker-support:1.2.1"
        })
    }
```
