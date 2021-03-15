# Android Gradle 常用命令

- 查看modeule的依赖关系，建议保存到文件

``` cmd/bash

    # bash
    ./gradlew :app:dependencies
    ./gradlew :app:dependencies > appDep.txt

    # cmd
    gradlew.bat :app:dependencies
    gradlew.bat :app:dependencies > appDep.txt


```

- 刷新Gradle依赖

``` cmd/bash

    # bash
    ./gradlew build --refresh-dependencies

    # cmd
    gradlew.bat build --refresh-dependencies

```

``` groovy
//直接在 build.gradle下添加
//排除依赖
configurations{
    all*.exclude module: "support-fragment"
}
//强制依赖
configurations.all {
    resolutionStrategy {
        force 'com.android.support:support-fragment:26.1.0'
    }
}
```

如果还是用重复依赖，检查项目中的其他module是否是使用了不同的lib版本


- 报错处理

Execution failed for task ':app:dataBindingGenBaseClassesDebug'.
Parameter 'directory' is not a directory

```cmd
./gradlew assembleDebug --rerun-tasks
```

- 打包aar附带源码

```groovy
// 源代码一起打包(不需要打包源代码的不要添加这几行)
task androidSourcesJar(type: Jar) {
    if (project.hasProperty("android")) {
        //支持java / kotlin源码上传
        from android.sourceSets.main.java.srcDirs
        //以下代码无法将kotlin源码上传
//        from android.sourceSets.main.java.sourceFiles
    } else {
        println project
        from sourceSets.main.allSource
    }
    classifier = 'sources'
}
artifacts {
    archives androidSourcesJar
}
```
