# Android AOP -- 简单使用

本文可能更多使用kotlin，java同理并无差异

相关内容如有错误请指正，更多信息参考文末友情链接

## Android&AOP简介

aop 切面编程  在另一个角度向你的代码加料

拦截<b>任何</b>方法，你可以决定方法是否执行，可以方法执行前后增添额外的操作

通常会和注解或反射一起使用

典型应用场景：

- 日志，埋点  
- 线程切换  
- 动态权限申请  
- 过滤重复点击  
- 修改三方库的执行逻辑（看具体代码）  

## Android AOP 副作用

1. 增加项目编译的压力（aop在代码编译期间进行注入），推荐在gradle中配置是否开启aop
2. aop未处理好（aop代码编写错误）在build时报错或app启动时直接崩溃
3. 有可能导致代码报错行数不对
4. 运行项目时可能会有提示classes.jar被占用或无法访问，此时是哟红电脑管家或其他工具结束掉`java.exe`重新运行即
5. （tip）将aop从项目中去除或关闭aop功能，之后需要clean一下项目

## 项目环境和aop插件

项目基本环境参考：

- gradle版本：`gradle-5.1.1-all`
- gradle插件版本：`classpath 'com.android.tools.build:gradle:3.4.1'`
- 项目中实用 java8 kotlin androidx （不影响aop）

aop插件和三方库：

- 沪江aspectjx插件 classpath : `com.hujiang.aspectjx:gradle-android-plugin-aspectjx:2.0.4`  
- module中引入插件： `apply plugin: 'com.hujiang.android-aspectjx'`  
- aop三方库 aspectrt： `api 'org.aspectj:aspectjrt:1.8.13'`  

## 详细引入

1. 在项目级别的build,gradle中`buildscript`闭包的`dependencies`中添加如下代码：

    ```groovy
        dependencies {
            classpath 'com.android.tools.build:gradle:3.4.1'x
            //mark  添加如下插件依赖
            classpath 'com.hujiang.aspectjx:gradle-android-plugin-aspectjx:2.0.4'
        }
    ```

2. 在application类型的module中添加aspectjx插件

    ```groovy
    apply plugin: 'com.hujiang.android-aspectjx'
    ```

3. 添加aspect的三方库依赖

    ```groovy
    dependencies {
        //aspectjrt aop
        api 'org.aspectj:aspectjrt:1.8.13'
    }
    ```

## 使用

### 场景一：使用aop在activity各个生命周期打印日志

```kotlin
//标识类为切面
@Aspect
class MyLogAop {
    /**
     * 定义切点
     */
    @Pointcut("execution(* android.app.Activity.on**(..))")
    fun methodLog() {
    }

    /**
     * 定义一个切面方法，使用Around注解方法包裹切点
     */
    @Around("methodLog()")
    @Throws(Throwable::class)
    fun aroundJoinPoint(joinPoint: ProceedingJoinPoint): Any? {
        //获取方法
        val methodSignature = joinPoint.signature as MethodSignature
        //方法所在类名
        val className = methodSignature.declaringType.simpleName
        //方法名
        val methodName = methodSignature.name
        //方法参数名
        val parameterNames = methodSignature.parameterNames
        //方法参数类型
        val parameterTypes = methodSignature.parameterTypes

        //切点（方法）参数
        val args = joinPoint.args
        //切点类型（方法）
        val kind = joinPoint.kind
        //切点（方法）源码位置
        val sourceLocation = joinPoint.sourceLocation

        //打印日志
        L.w("before --  ${className}#${methodName}")
        //执行方法
        val proceed = joinPoint.proceed()
        //打印日志
        L.w("after --  ${className}#${methodName}")

        //返回执行结果
        return proceed
    }
}
```

- `@Aspect`注解标识在类上，标识该类为一个切面  
- `@Pointcut`切入点，参数值为切点表达式  
- `@Around` 类似的还有`@Before` `@After`,用于包裹切点，或在切点前、切点后执行方法，参数为切点表达式或被`@Pointcut`注解的方法调用  
- 在`aroundJoinPoint`方法中写了相关获取切点周围数据的方法，并在切点方法执行前后打印日志，完全无需改动原方法的任何代码  

## 友情链接

[Android AOP 三剑客：APT AspectJ Javassist](https://blog.csdn.net/xiaoru5127/article/details/82497250)  
[安卓AOP三剑客:APT,AspectJ,Javassist](https://www.jianshu.com/p/dca3e2c8608a)  
[美团热更新（热修复）使用](https://blog.csdn.net/fengyeNom1/article/details/79025908)  
[神奇的Hook机制，一文读懂AOP编程](https://blog.csdn.net/c10wtiybq1ye3/article/details/87999882)  
[android AOP面向切面编程 aspectjrt](https://blog.csdn.net/tong6320555/article/details/97755677)