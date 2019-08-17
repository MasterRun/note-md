# 使用gitee发布aar作为maven仓库

### 1、创建项目库
在gitee上创建新项目 同时本地创建相应的库

### 2、编写gradle代码
在Android项目的library属性的Module中添加gradle文件：maven-repository.gradle
```groovy
apply plugin: 'maven'

ext {
    PUBLISH_ARTIFACT_ID = 'core'
    PUBLISH_VERSION = '1.0.0'
}

uploadArchives {
    repositories.mavenDeployer {
        //这里是本地仓库路径
        def deployPath = file(REMOTE_REPO_PATH)
        repository(url: "file://${deployPath.absolutePath}")
        //打包的相关信息
        pom.project {
            groupId PUBLISH_GROUP_ID
            artifactId project.PUBLISH_ARTIFACT_ID
            version project.PUBLISH_VERSION
        }
    }
}

// 源代码一起打包(不需要打包源代码的不要添加这几行)
task androidSourcesJar(type: Jar) {
    classifier = 'sources'
    from android.sourceSets.main.java.sourceFiles
}

artifacts {
    archives androidSourcesJar
}
```
紧接着在module中引用此gradle文件
```groovy
apply from: './maven-repository.gradle'
```

### 3、打包aar发布
在右侧的gradle插件中找到对应的module中upload，运行uploadArchives任务
运行成功后会在本地仓库路径生成aar及相应的文件
使用git add   commit  push  到远程仓库

### 4、引用远程的
首先在项目的build.gradle的repositories中添加仓库地址
```groovy
allprojects {
    repositories {
        maven { url "https://raw.githubusercontent.com/UserName/ProjectName/master" }  
        maven { url "https://gitee.com/runrunrun/maven_repository/raw/master" }
    }
}
```
<b>
如果是码云的仓库，仓库地址是  [项目地址]+[/raw/master] 
<br/>
<b>
如果是github的仓库 项目地址是  [项目地址]+[/master] ，把其中的github.com 改为raw.githubusercontent.com
