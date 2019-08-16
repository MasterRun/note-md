# RxJava常用操作符介绍
[参考](https://www.jianshu.com/p/823252f110b0)
- [依赖引入](#依赖引入)
- [创建操作](#创建操作)
- [辅助操作](#辅助操作)
- [变换操作](#变换操作)
- [线程切换](#线程切换)
- [取消订阅](#取消订阅)

### 简介
  RxJava本质上是一个异步操作库，是一个能让你用极其简洁的逻辑去处理繁琐复杂任务的异步事件库。

  Android平台上为已经开发者提供了AsyncTask,Handler等用来做异步操作的类库，那我们为什么还要选择RxJava呢？答案是简洁！RxJava可以用非常简洁的代码逻辑来解决复杂问题；而且即使业务逻辑的越来越复杂，它依然能够保持简洁！再配合上Lambda表达式代码会更加简洁。

  ```Java
  //Thread版
  new Thread() {
            @Override
            public void run() {
                super.run();
                //一些繁重的IO操作

                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        //回到主线程更新ui
                    }
                });
            }
        }.start();
  ```
  ```Java
  //RxJava 
Disposable disposable = Observable.just(1)
        .observeOn(Schedulers.io())
        .map(new Function<Integer, Object>() {
            @Override
            public Object apply(Integer integer) throws Exception {
                //一些繁重的IO操作
                return "your result";
            }
        })
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe(new Consumer<Object>() {
            @Override
            public void accept(Object o) throws Exception {
                //在主线程更新ui
            }
        });
  ```
  ```Java
  //RxJava  lamdba版
  Disposable disposable = Observable.just(1)
        .observeOn(Schedulers.io())
        .map(integer -> {
            //一些繁重的IO操作
            return "your result";
        })
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe(o -> {
            //在主线程更新ui
        });
  ```
  ```kotlin
  //kotlin版
  val disposable = Observable.just(1)
        .observeOn(Schedulers.io())
        .map {
            //一些繁重的IO操作
            "your result"
        }
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe { o ->
            //在主线程更新ui
        }
  ```

### 依赖引入
```groovy
api "io.reactivex.rxjava2:rxjava:${versions.rxjava}"
api "io.reactivex.rxjava2:rxandroid:${versions.rxandroid}"
```
参考版本：<br/>
RxJava `2.2.7`<br/>
RxAndroid `2.1.1`

### 创建操作
1. create  原始方法
   ```Java
   //创建
   public static <T> Observable<T> create(ObservableOnSubscribe<T> source)
   ```
   ```Java
   //订阅
   public final void subscribe(Observer<? super T> observer)
   ```

   注：RxJava2发射null会抛出异常，可在onError中catch到异常，否则就crash了。异常是warning级别的。

2. just

   ```Java
   <T> Observable<T> just(T item)
   <T> Observable<T> just(T item1, T item2)
   <T> Observable<T> just(T item1, T item2, T item3)
   <T> Observable<T> just(T item1, T item2, T item3, T item4)
   <T> Observable<T> just(T item1, T item2, T item3, T item4, T item5)
   ```
   最多重载到10个参数

3. from
 - fromArray
   ```Java
   <T> Observable<T> fromArray(T... items)
   ```
   >与just类似，just方法的多参数重载就是使用fromArray实现，而fromArray当>数组只有一个值时使用just实现 
   
 - fromIterable
   ```Java
   <T> Observable<T> fromIterable(Iterable<? extends T> source)
   ```
   > 实现Iterable接口的类都可以使用此方法创建

4. timber
   ```Java
   Observable<Long> timer(long delay, TimeUnit unit)
   Observable<Long> timer(long delay, TimeUnit unit, Scheduler scheduler)
   ```
   延迟发射数据0L

5. range
   > 发送指定范围的数
   - range
   ```Java
   Observable<Integer> range(final int start, final int count)
   ```
   - rangeLong
   ```Java
   Observable<Long> rangeLong(long start, long count)
   ```

6. interval
   - interval
   ```Java
   Observable<Long> interval(long period, TimeUnit unit)
   Observable<Long> interval(long initialDelay, long period, TimeUnit unit)
   Observable<Long> interval(long initialDelay, long period, TimeUnit unit, Scheduler scheduler)
   ```
   > 间隔发射数据<br>
   > initialDelay 是首次发射的延迟，不指定就是period<br>
   > period是周期<br>
   > timeunit 单间单位<br>

   - intervalRange
   ```Java
   Observable<Long> intervalRange(long start, long count, long initialDelay, long period, TimeUnit unit)
   Observable<Long> intervalRange(long start, long count, long initialDelay, long period, TimeUnit unit, Scheduler scheduler)
   ```
   > 间隔发送指定范围的数据

7. zip
   ```Java
   public static <T1, T2, R> Observable<R> zip(
            ObservableSource<? extends T1> source1,
            ObservableSource<? extends T2> source2,
            BiFunction<? super T1, ? super T2, ? extends R> zipper)

   public final <U, R> Observable<R> zipWith(
            ObservableSource<? extends U> other,
            BiFunction<? super T, ? super U, ? extends R> zipper)
   ```
   > 将若干个源合并变换后成一个源，若某个源发射的数据没有数据与之对应，此数据不参与变换<br/>
   > 该函数有若干重载

8. merge 合并源  交错发射
9. concat  拼接源 按顺序发射

### 辅助操作
1. repeat
   ```Java
   public final Observable<T> repeat(long times)
   public final Observable<T> repeat()
   ```
   > 重复发送上游的数据，times用于指定重复的次数，不传为`Long.MAX_VALUE`

2. delay
   ```Java
   public final Observable<T> delay(long delay, TimeUnit unit)
   public final Observable<T> delay(long delay, TimeUnit unit, Scheduler scheduler)
   ```
   > 上游的数据，延迟送到下游
3. timeout
   ```Java
   public final Observable<T> timeout(long timeout, TimeUnit timestUnit)
   public final Observable<T> timeout(long timeout, TimeUnit timeUnit, ObservableSource<? extends T> other)
   public final Observable<T> timeout(long timeout, TimeUnit timeUnit, Scheduler scheduler)
   public final Observable<T> timeout(long timeout, TimeUnit timeUnit, Scheduler scheduler, ObservableSource<? extends T> other)
   ```
   > 该函数有若干重载<br/>
   > 设置超时时间，若到时间还未接收到上游数据，就会发射null，除非指定了其他的源：other

3. filter
   ```Java
   public final Observable<T> filter(Predicate<? super T> predicate)
   ```
   > 过滤
4. toList
5. toMap

### 变换操作
1. map
   ```Java
   public final <R> Observable<R> map(Function<? super T, ? extends R> mapper)
   ```
   > 转换方法，可将上游的数据转换为目标数据，上游类似方法方法的入参，下游类似方法的出参，在map中是要执行的代码
2. flatmap
   ```Java
   public final <R> Observable<R> flatMap(Function<? super T, ? extends ObservableSource<? extends R>> mapper)
   ```
   > 将上游的数据转换为新的源(返回的参数是Observable，此方法上游源的数量与下游源的数量不一定相同)
   > 不保证顺序
   > 该函数有若干重载和系列方法

3. concatMap
   ```Java
   public final <R> Observable<R> concatMap(Function<? super T, ? extends ObservableSource<? extends R>> mapper)
   ```
   > 与flatmap类似，保证顺序

### 线程切换
1. Schedulers [参考](https://www.jianshu.com/p/12638513424f)
   - AndroidSchedulers.mainThread()
    > 在RxAndroid包中，指定Android的UI线程
   - Schedulers.io()
    > 用于IO密集型的操作<br>
    > 读写SD卡文件，查询数据库，访问网络等
   - Schedulers.computation()
    > 用于CPU 密集型计算任务，即不会被 I/O 等操作限制性能的耗时操作<br>
    > xml,json文件的解析，Bitmap图片的压缩取样等
   - Schedulers.newThread()
    > 在每执行一个任务时创建一个新的线程(一般不建议)
   - Scheduler.from(@NonNull Executor executor)
    > 指定一个线程调度器，由此调度器来控制任务的执行策略。
   - Schedulers.trampoline()
    > 在当前线程立即执行任务，如果当前线程有任务在执行，则会将其暂停，等插入进来的任务执行完之后，再将未完成的任务接着执行。
   - Schedulers.single()
    > 拥有一个线程单例，所有的任务都在这一个线程中执行，当此线程中有任务执行时，其他任务将会按照先进先出的顺序依次执行。
  
2. subscribeOn
   >来指定对数据的处理运行在特定的线程调度器Scheduler上，直到遇到observeOn改变线程调度器
   >只生效一次
3. observeOn
   > 指定下游操作运行在特定的线程调度器Scheduler上。若多次设定，每次均起作用。

### 取消订阅
1. Disposable
   > 一般情况下subscribe之后会返回Disposable对象，此对象用于取消订阅<br>
   > 取消订阅后，后续的subscribe方法将不会再执行
   ```Java
   public interface Disposable {
    void dispose();
    boolean isDisposed();
   }
   ```
2. CompositeDisposable
   > 类似一个集合，RxJava2提供的Disposable的容器<br>
   > 可使用`public void dispose()`或`public void clear()`方法批量取消订阅

   > Android开发中，在Activity的onDestroy方法或Fragment当然onDestroyView方法中取消订阅,避免在页面销毁后耗时任务再去更新UI

###  Observable之兄弟姐妹
|类型|描述|
|---|---|
|Observable|能够发射0或n个数据，并以成功或错误事件终止。|
|Flowable|能够发射0或n个数据，并以成功或错误事件终止。 <br>支持背压，可以控制数据源发射的速度。|
|Single|只发射单个数据或错误事件。|
|Completable|不发射数据，只处理 onComplete 和 onError 事件|
|Maybe|能够发射0或者1个数据，以及完成通通知或异常通知。|



### 原文链接

[码云](https://gitee.com/runrunrun/note-md/blob/master/RxJava%E5%B8%B8%E7%94%A8%E6%93%8D%E4%BD%9C%E7%AC%A6%E4%BB%8B%E7%BB%8D.md)
[github](https://github.com/MasterRun/note-md/blob/master/RxJava%E5%B8%B8%E7%94%A8%E6%93%8D%E4%BD%9C%E7%AC%A6%E4%BB%8B%E7%BB%8D.md)
[个人博客]()

### 友情链接

RxBus
[码云链接](https://gitee.com/runrunrun/note-md/blob/master/RxBus%20Java%E4%B8%8EKotlin%E5%AE%9E%E7%8E%B0.md)
[github链接](https://github.com/MasterRun/note-md/blob/master/RxBus%20Java%E4%B8%8EKotlin%E5%AE%9E%E7%8E%B0.md)
[个人博客](http://150g46148t.imwork.net:19001/archives/rxbus)  
