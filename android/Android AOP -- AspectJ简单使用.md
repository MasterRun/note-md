# Android AOP -- AspectJ简单使用

本文可能更多使用kotlin，java同理并无差异

相关内容如有错误请指正，更多信息参考文末友情链接

## Android&AOP简介

aop 切面编程  在另一个角度向你的代码加料

aop三剑客 APT  AspectJ Javassist

### APT

注解处理器

在编译期间生成.java (不仅限于java，kotlin，静态资源等都可以)  

代表框架：DataBinding、Dagger2、ButterKnife、EventBus3

### AspectJ

在编译期间注入代码

拦截<b>任何</b>方法，你可以决定方法是否执行，可以方法执行前后增添额外的操作

通常会和注解或反射一起使用

典型应用场景：

- 日志，埋点  用户行为统计  
- 线程切换  
- 动态权限申请  
- 检查网络状态是否可用  
- 过滤重复点击  
- 修改三方库的执行逻辑（看具体代码）  
- 检查用户登录  

### Javassist

代表框架：热修复框架HotFix 、Savior（InstantRun）  

Javassist 是一个编辑字节码的框架，作用是修改编译后的 class 字节码。  

## Android AspectJ 副作用

1. 增加项目编译的压力（aop在代码编译期间进行注入），推荐在gradle中配置是否开启aop
2. aop未处理好（aop代码编写错误）在build时报错或app启动时直接崩溃
3. 有可能导致代码报错行数不对
4. 运行项目时可能会有提示classes.jar被占用或无法访问，此时用电脑管家或其他工具结束掉`java.exe`重新运行即可
5. （tip）将aop从项目中去除或关闭aop功能，之后需要clean一下项目

## 项目环境和AspectJ插件

项目基本环境参考：

- gradle版本：`gradle-5.1.1-all`、`gradle-5.6.4-all`
- gradle插件版本：`classpath 'com.android.tools.build:gradle:3.4.1'`
                `classpath 'com.android.tools.build:gradle:3.4.2'`
- 项目中实用 java8 kotlin androidx （不影响aop）

AspectJ插件和三方库：

- 沪江aspectjx插件 `classpath  'com.hujiang.aspectjx:gradle-android-plugin-aspectjx:2.0.4'`  
                 `classpath 'com.hujiang.aspectjx:gradle-android-plugin-aspectjx:2.0.10'`
- module中引入插件： `apply plugin: 'com.hujiang.android-aspectjx'`  
- aop三方库 aspectrt： `api 'org.aspectj:aspectjrt:1.8.13'`  
                      `api 'org.aspectj:aspectjrt:1.9.5'`  

## 详细引入

1. 在项目级别的build,gradle中`buildscript`闭包的`dependencies`中添加如下代码：

    ```groovy
        dependencies {
            //已知兼容的两个版本  添加插件依赖  ，以下提供2个版本
            classpath 'com.android.tools.build:gradle:3.4.2' //gradle-plugin 3.2.1 -> gradle 5.4.2
            classpath 'com.hujiang.aspectjx:gradle-android-plugin-aspectjx:2.0.10'

            classpath 'com.android.tools.build:gradle:3.4.1'
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
        //aspectjrt aop ，以下提供2个版本
        api 'org.aspectj:aspectjrt:1.8.13'
        api 'org.aspectj:aspectjrt:1.9.5'
    }
    ```

## 使用

AspectJ表达式
| 表达式类型  | 描述                                       |
| ----------- | ------------------------------------------ |
| execution   | 过滤出方法执行时的连接点                   |
| within      | 过滤出制定类型内方法                       |
| this        | 过滤当前AOP对象的执行时方法                |
| target      | 过滤目标对象的执行时方法                   |
| args        | 过滤出方法执行时参数匹配args的方法         |
| @within     | 过滤出持有指定注解类型内的方法             |
| @target     | 过滤目标对象持有指定注解类型的方法         |
| @args       | 过滤当前执行的传入的参数持有指定注解的方法 |
| @annotation | 过滤当前执行的持有指定注解的方法           |

### 场景一：使用aop在activity各个生命周期打印日志

```kotlin
//标识类为切面
@Aspect
class MyLogAspect {
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

```java

@Aspect
public class ActivityLifecycleLog {

    private static final String TAG = "ActivityLifecycleLog";

    @Pointcut("execution(* android.app.Activity.on**(..))")
    public void logPointcut() {
    }

    @Around("logPointcut()")
    public Object printLifecycleLog(ProceedingJoinPoint joinPoint) throws Throwable {

        //获取方法
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();

        //获取方法所在类名
        String declaringClassName = signature.getDeclaringType().getSimpleName();
        //String simpleName = signature.getDeclaringTypeName();

        //获取方法名
        String methodName = signature.getName();

        //获取参数名
        String[] parameterNames = signature.getParameterNames();
        //获取参数类型
        Class[] parameterTypes = signature.getParameterTypes();
        //切点（方法）参数
        Object[] args = joinPoint.getArgs();
        //切点类型（方法）
        String kind = joinPoint.getKind();

        //执行切点的this对象
        Object aThis = joinPoint.getThis();
        //执行切点的目标对象
        Object target = joinPoint.getTarget();

        String className = aThis.getClass().getName();

        //切点（方法）源码位置
        SourceLocation sourceLocation = joinPoint.getSourceLocation();

        Log.d(TAG, String.format("before --  %s#%s", className, methodName));
        //执行方法
        Object proceed = joinPoint.proceed();
        Log.d(TAG, String.format("after --  %s#%s", className, methodName));
        return proceed;
    }
}

```


- `@Aspect`注解标识在类上，标识该类为一个切面  
- `@Pointcut`切入点，参数值为切点表达式  
- `@Around` 类似的还有`@Before` `@After`,用于包裹切点，或在切点前、切点后执行方法，参数为切点表达式或被`@Pointcut`注解的方法调用  
- 在`aroundJoinPoint`方法中写了相关获取切点周围数据的方法，并在切点方法执行前后打印日志，完全无需改动原方法的任何代码  

## 副作用

1. 编译时间加长
2. 编译时可能出现 "classes.jar" 相关提示，是因为编译期间生成的旧的classes.jar被占用无法删除，杀死后台的java.exe再次编辑即可
3. 切面编写没有提示，错误的话可能导致APP启动直接闪退，现象很明显
4. 只能对打包进app的代码进行拦截，例如三方库代码，项目代码，对于Android系统源码无法拦截

## 友情链接

[Android AOP 三剑客：APT AspectJ Javassist](https://blog.csdn.net/xiaoru5127/article/details/82497250)  
[安卓AOP三剑客:APT,AspectJ,Javassist](https://www.jianshu.com/p/dca3e2c8608a)  
[美团热更新（热修复）使用](https://blog.csdn.net/fengyeNom1/article/details/79025908)  
[神奇的Hook机制，一文读懂AOP编程](https://blog.csdn.net/c10wtiybq1ye3/article/details/87999882)  
[android AOP面向切面编程 aspectjrt](https://blog.csdn.net/tong6320555/article/details/97755677)  
[一文读懂 AOP | 你想要的最全面 AOP 方法探讨](https://www.jianshu.com/p/0799aa19ada1)
[从Android优雅权限框架理解AOP思想(2) 原理篇](https://www.jianshu.com/p/12295bce18b0)
[@Pointcut 的 12 种用法](https://www.jianshu.com/p/3c73065ecbdf)