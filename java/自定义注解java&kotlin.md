# 自定义注解java&kotlin
注解的作用就不多少，直接上干货 [参考](https://blog.csdn.net/wuyuxing24/article/details/81139846)
### 1、元注解
元注解是用来定义其他注解的注解(在自定义注解的时候，需要使用到元注解来定义我们的注解)。

java.lang.annotation提供了四种元注解：@Retention、 @Target、@Inherited、@Documented。

|元注解|说明
|:---:| :---: |
|@Target|表明我们注解可以出现的地方。是一个ElementType枚举|
|@Retention|这个注解的的存活时间|
|@Document|表明注解可以被javadoc此类的工具文档化|
|@Inherited|是否允许子类继承该注解，默认为false|

#### 1.1 @Target
&nbsp;&nbsp;@Target元注解用来表明我们注解可以出现的地方，参数是一个ElementType类型的数组，所以@Target可以设置注解同时出现在多个地方。比如既可以出现来类的前面也可以出现在变量的前面。

|@Target-ElementType类型|说明|
|:---:|:---:|
|ElementType.TYPE|接口、类、枚举、注解|
|ElementType.FIELD|字段、枚举的常量|
|ElementType.METHOD|方法|
|ElementType.PARAMETER|方法参数|
|ElementType.CONSTRUCTOR|构造方法|
|ElementType.LOCAL_VARIABLE|局部变量|
|ElementType.FIELDANNOTATION_TYPE|注解|
|ElementType.PACKAGE|包|

<b>注：在kotlin中ElementType对应AnnotationTarget,而其中包括kotlin对应的类型，略有差异童鞋们可自行查看kotlin源码有相关注释说明</b>

#### 1.2 @Retention
&nbsp;&nbsp;@Retention表示需要在什么级别保存该注释信息，用于描述注解的生命周期(即：被描述的注解在什么范围内有效)。参数是RetentionPolicy枚举对象。

|@Retention-RetentionPolicy类型|说明|
|:---:|:---:|
|RetentionPolicy.SOURCE|注解只保留在源文件，当Java文件编译成class文件的时候，注解被遗弃|
|RetentionPolicy.CLASS|	注解被保留到class文件，但jvm加载class文件时候被遗弃，这是默认的生命周期|
|RetentionPolicy.RUNTIME|注解不仅被保存到class文件中，jvm加载class文件之后，仍然存在|

<b>注：在kotlin中RetentionPolicy对应AnnotationRetention，同样是三种参数类型 </b>

    SOURCE < CLASS < RUNTIME,前者能作用的地方后者一定也能作用.
    
#### 1.3 @Document
&nbsp;&nbsp;@Document表明我们标记的注解可以被javadoc此类的工具文档化。

#### 1.4 @Inherited
&nbsp;&nbsp;@Inherited表明我们标记的注解是被继承的。比如，如果一个父类使用了@Inherited修饰的注解，则允许子类继承该父类的注解。

### 2 自定义注解
#### 2.1 自定义运行时注解
运行时注解：在代码运行的过程中通过反射机制找到我们自定义的注解，然后做相应的事情。

步骤 1、声明注解  2、解析注解。

##### 2.1.1 声明注解
1. 通过@Retention元注解确定我们注解是在运行的时候使用。
2. 通过@Target确定我们注解是作用在什么上面的(变量、函数、类等)。
3. 确定我们注解需要的参数。

for example (kotlin code)
```kotlin
@Target(AnnotationTarget.FIELD)
@Retention(AnnotationRetention.RUNTIME)
annotation class Model(val clazz: KClass<out BaseModel>)
```

##### 2.1.2 解析注解
- 首先将注解使用到相应的类或字段方法上
```kotlin
class aClass{    
    @Model(MainModuleModel::class)
    override lateinit var model: IMainModule.IModel
}
```

- 通过静态方法作为入口，将使用注解的字段，方法等所属的类对象传入方法进行解析
```kotlin
object ModelBinder {

    fun bind(any: Any) {
        //如果绑定的presenter ，后续注入model
        if (any is IBaseMvp.IBasePresenter<IBaseMvp.IBaseModel, IBaseMvp.IBaseView>) {
            val targetClass = any::class
            //找有model注解的字段
            targetClass.memberProperties.forEach {
                val modelAnnotation = it.javaField?.getAnnotation(Model::class.java)
                if (modelAnnotation != null) {
                    it.isAccessible = true
                    //从注解中获取主要注入的model类
                    val modelJavaClazz = modelAnnotation.clazz.java
                    val myModel = modelJavaClazz.newInstance()
                    //如果类型正确
                    val isInstance = it.javaField?.type?.isInstance(myModel)
                    if (isInstance != null && isInstance) {
                        //注入实例
                        it.javaField?.set(any, myModel)
                    } else {
                        throw  Exception("type incompatible")
                    }
                }
            }
        }
    }
}
```

<b>Java反射机制机制还不了解的童鞋需要提前预习一下反射机制哦</b>

<b>注：在kotlin中，有properties和functions ，如果想从Properties中获取字段，可以通过```property.javaField```获取，
同时为了可访问，推荐使用```property.isAccessible = true```,这样kotlin的属性对应的field getter setter都会设置为可访问</b>

<b>另kotlin中的KClass与Java中的Class需要分清，相信通过强大的IDEA或者Androidstudio+度娘可以轻松帮你搞定这些</b>


这里贴一波注解相关的方法(Java)
```
    /**
     * 指定类型的注释是否存在于此元素上
     */
    default boolean isAnnotationPresent(Class<? extends Annotation> annotationClass) {
        return getAnnotation(annotationClass) != null;
    }

    /**
     * 返回该元素上存在的指定类型的注解
     */
    <T extends Annotation> T getAnnotation(Class<T> annotationClass);

    /**
     * 返回该元素上存在的所有注解
     */
    Annotation[] getAnnotations();

    /**
     * 返回该元素指定类型的注解
     */
    default <T extends Annotation> T[] getAnnotationsByType(Class<T> annotationClass) {
        return AnnotatedElements.getDirectOrIndirectAnnotationsByType(this, annotationClass);
    }

    /**
     * 返回直接存在与该元素上的所有注释(父类里面的不算)
     */
    default <T extends Annotation> T getDeclaredAnnotation(Class<T> annotationClass) {
        Objects.requireNonNull(annotationClass);
        // Loop over all directly-present annotations looking for a matching one
        for (Annotation annotation : getDeclaredAnnotations()) {
            if (annotationClass.equals(annotation.annotationType())) {
                // More robust to do a dynamic cast at runtime instead
                // of compile-time only.
                return annotationClass.cast(annotation);
            }
        }
        return null;
    }

    /**
     * 返回直接存在该元素岸上某类型的注释
     */
    default <T extends Annotation> T[] getDeclaredAnnotationsByType(Class<T> annotationClass) {
        return AnnotatedElements.getDirectOrIndirectAnnotationsByType(this, annotationClass);
    }

    /**
     * 返回直接存在与该元素上的所有注释
     */
    Annotation[] getDeclaredAnnotations();
```