# Android Gradle 常用命令

- 查看modeule的依赖关系，建议保存到文件

``` cmd/bash

    # bash
    ./gradlew :app:dependencies
    ./gradlew :app:dependencies > appDep.txt

    # cmd
    gradlew.bat :app:dependencies


```

- 刷新Gradle依赖

``` cmd/bash

    # bash
    ./gradlew build --refresh-dependencies

    # cmd
    gradlew.bat build --refresh-dependencies

```
