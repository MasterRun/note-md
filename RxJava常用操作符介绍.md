# RxJava常用操作符介绍

- [依赖引入](#依赖引入)
- [创建操作](#创建操作)
- [辅助操作](#辅助操作)
- [变换操作](#变换操作)
- [线程切换](#线程切换)
- [取消订阅](#取消订阅)

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
1. subscribeOn
2. observeOn

### 取消订阅
1. Disposable
2. CompositeDisposable