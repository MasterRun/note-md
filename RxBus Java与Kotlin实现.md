# RxBus
可自定义类型替代Object类型
Java版
```Java
public class RxBus {
    private final FlowableProcessor<Object> mBus;

    private RxBus() {
        this.mBus = PublishProcessor.create().toSerialized();
    }

    public static RxBus get() {
        return Holder.BUS;
    }

    public void post(Object obj) {
        mBus.onNext(obj);
    }

    public <T> Flowable<T> toFlowable(Class<T> tClass) {
        return mBus.ofType(tClass);
    }

    public Flowable<Object> toFlowable() {
        return mBus;
    }

    public boolean hasSubscribers() {
        return mBus.hasSubscribers();
    }

    private static class Holder {
        private static final RxBus BUS = new RxBus();
    }
}
```
Kotlin版
```Kotlin
object RxBus {

    private val mBus: FlowableProcessor<Any> = PublishProcessor.create<Any>().toSerialized()

    fun post(obj: Any) {
        mBus.onNext(obj)
    }

    fun <T> toFlowable(tClass: Class<T>): Flowable<T> {
        return mBus.ofType(tClass)
    }

    fun toFlowable(): Flowable<Any> {
        return mBus
    }

    fun hasSubscribers(): Boolean {
        return mBus.hasSubscribers()
    }

}
```