# Gradle 发布jar&aar

## Gradle5x

```groovy
apply plugin: 'maven'
ext {
    PUBLISH_ARTIFACT_ID = 'test'
    PUBLISH_VERSION = '1.0.0'
    PUBLISH_GROUP_ID = 'com.test.group'
    REMOTE_REPO_DIR = new File(rootDir.parent, "repoLocal")
}

uploadArchives {
    //本地配置
    repositories.mavenDeployer {
        def deployPath = REMOTE_REPO_DIR
        repository(url: "file://${deployPath.absolutePath}")
        println "deployPath: ${deployPath.absolutePath}"
        pom.project {
            groupId project.PUBLISH_GROUP_ID
            artifactId project.PUBLISH_ARTIFACT_ID
            version project.PUBLISH_VERSION
        }
    }
    //阿里云效配置
/*    repositories.mavenDeployer {
        repository(url: AliyunRepo_RELEASE) {
            authentication(userName: AliyunRepo_USERNAME, password: AliyunRepo_PASSWORD)
        }
        snapshotRepository(url: AliyunRepo_SNAPSHOT) {
            authentication(userName: AliyunRepo_USERNAME, password: AliyunRepo_PASSWORD)
        }
        //pom配置
        pom.project {
            groupId project.PUBLISH_GROUP_ID
            artifactId project.PUBLISH_ARTIFACT_ID
            version project.PUBLISH_VERSION
        }
    }*/
}
```

## Gradle7x

```groovy
plugins {
    //添加插件
    id 'maven-publish'
}
ext {
    PUBLISH_ARTIFACT_ID = 'test'
    PUBLISH_VERSION = '1.0.0'
    PUBLISH_GROUP_ID = 'com.test.group'
    REMOTE_REPO_DIR = new File(rootDir.parent, "repoLocal")
}

task sourceJar(type: Jar) {
    getArchiveClassifier().set('sources')
    from android.sourceSets.main.java.srcDirs
}

afterEvaluate {
    publishing {
        repositories {
            maven {
                def deployPath = REMOTE_REPO_DIR
                url = "file://${deployPath.absolutePath}"
            }
        }
        publications {
            //发布的名称
            myPublicationName(MavenPublication) {
                // Configure the publication here
                groupId project.PUBLISH_GROUP_ID
                artifactId project.PUBLISH_ARTIFACT_ID
                version project.PUBLISH_VERSION
                // from components.release
                from components.debug
                artifact sourceJar
            }
        }
    }
}
```

提示在gradle8中，不会ComponentCreation，使用`android.disableAutomaticComponentCreation=true`可预览feature

### 解决方案

https://www.5axxw.com/questions/content/gquaxz

根据PublishingOptions，必须定义一个android.publishing块：

``` groovy
android {
    publishing {
        singleVariant('release') {
            withSourcesJar()
            withJavadocJar()
        }
        // ...
    }
}
```

要同时定义多个变体，请执行以下操作：

```groovy
android {
    publishing {
        multipleVariants {
            withSourcesJar()
            withJavadocJar()
            allVariants()
        }
    }
}
```

然后，`components.getByName('release')`将再次被知道。

## kts
https://docs.gradle.org/5.6.3/userguide/kotlin_dsl.html