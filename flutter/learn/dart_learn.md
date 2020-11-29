# Dart基础

## 变量的声明

- 明确声明
- 类型推导 `var/dynamic/const/final`

    `final` 声明的常量是运行时常量

    `const` 声明的常量是编译期常量

 `const`可作用于构造函数,用于创建共享对象

## 集合

`List Set Map`

- List

```Dart
var letters = ['a', 'b', 'c', 'd'];
List<int> numbers = [1, 2, 3, 4];
```

- Set

```Dart
var lettersSet = {'a', 'b', 'c', 'd'};
Set<int> numbersSet = {1, 2, 3, 4};
```

- Map

```Dart
var infoMap1 = {'name': 'why', 'age': 18};
Map<String, Object> infoMap2 = {'height': 1.88, 'address': '北京市'};
```

## 函数

函数 `Function`

函数声明可省略返回值

如果函数体只有一个表达式，可以使用箭头语法

dart函数没有重载,类可拥有命名构造方法

```Dart
sum(num1, num2) => num1 + num2;
```

### 函数参数

```txt
命名可选参数: {param1, param2, ...}
位置可选参数: [param1, param2, ...]
```

只有可选参数可以有默认值

### 函数是一等公民

```Dart
main(List<String> args) {
  // 1.将函数赋值给一个变量
  var bar = foo;
  print(bar);

  // 2.将函数作为另一个函数的参数
  test(foo);

  // 3.将函数作为另一个函数的返回值
  var func =getFunc();
  func('kobe');
}

// 1.定义一个函数
foo(String name) {
  print('传入的name:$name');
}

// 2.将函数作为另外一个函数的参数
test(Function func) {
  func('coderwhy');
}

// 3.将函数作为另一个函数的返回值
getFunc() {
  return foo;
}
```

### 匿名函数( anonymous function)，或lambda或closure

```dART
  // 使用forEach遍历: 匿名函数
  movies.forEach((item) {
    print(item);
  });
```

### 返回值

所有函数都返回一个值。如果没有指定返回值，则语句返回null;隐式附加到函数体

# Dart异步

dart是单线程的

基于事件的回调机制,事件循环(eventLoop)

阻塞式调用和非阻塞式调用

- 阻塞和非阻塞关注的是程序在等待调用结果（消息，返回值）时的状态。
- 阻塞式调用： 调用结果返回之前，当前线程会被挂起，调用线程只有在得到调用结果之后才会继续执行。
- 非阻塞式调用： 调用执行之后，当前线程不会停止执行，只需要过一段时间来检查一下有没有结果返回即可

## Future

```Dart

main(List<String> args) {
  var future = getNetworkData();
  future.then((value) {
    print(value);
  }).catchError((error) {
    // 捕获出现异常时的情况
    print(error);
  });;
}

Future<String> getNetworkData() {
  return Future<String>(() {
    sleep(Duration(seconds: 3));
    return "network data";
  });
```

- Future通常会对一些异步的操作进行封装；
- 通过.then监听Future完成
- 通过.catchError监听Future异常

Future的两种状态:  
未完成状态（uncompleted）  
完成状态（completed）

then可进行链式调用

```Dart
Future.value(value);
Future.error(object);
Future.delayed(时间, 回调函数);
```

### await async

在async方法中可使用await关键字以同步的代码格式调用异步方法，并返回Future

```Dart
Future<String> getNetworkData() async {
  var result = await Future.delayed(Duration(seconds: 3), () {
    return "network data";
  });

  return "请求到的数据：" + result;
}
```

### 执行顺序

事件循环（Event Loop） -> 事件队列（Event Queue）
微任务队列（Microtask Queue）

1. Dart的入口是main函数，所以main函数中的代码会优先执行；
2. main函数执行完后，会启动一个事件循环（Event Loop）就会启动，启动后开始执行队列中的任务；
3. 首先，会按照先进先出的顺序，执行 微任务队列（Microtask Queue）中的所有任务；
4. 其次，会按照先进先出的顺序，执行 事件队列（Event Queue）中的所有任务；


#### 创建微任务

```Dart
import "dart:async";

main(List<String> args) {
  scheduleMicrotask(() {
    print("Hello Microtask");
  });
}
```

Future的代码是加入到事件队列还是微任务队列呢？

Future中通常有两个函数执行体：

- Future构造函数传入的函数体
- then的函数体（catchError等同看待）

那么它们是加入到什么队列中的呢？

- Future构造函数传入的函数体放在事件队列中
- then的函数体要分成三种情况：
  - 情况一：Future没有执行完成（有任务需要执行），那么then会直接被添加到Future的函数执行体后；
  - 情况二：如果Future执行完后就then，该then的函数体被放到如微任务队列，当前Future执行完后执行微任务队列；
  - 情况三：如果Future是链式调用，意味着then未执行完，下一个then不会执行；

```dart
// future_1加入到eventqueue中，紧随其后then_1被加入到eventqueue中
Future(() => print("future_1")).then((_) => print("then_1"));

// Future没有函数执行体，then_2被加入到microtaskqueue中
Future(() => null).then((_) => print("then_2"));

// future_3、then_3_a、then_3_b依次加入到eventqueue中
Future(() => print("future_3")).then((_) => print("then_3_a")).then((_) => print("then_3_b"));
```

Demo:

```dart
import "dart:async";

main(List<String> args) {
  print("main start");

  Future(() => print("task1"));

  final future = Future(() => null);

  Future(() => print("task2")).then((_) {
    print("task3");
    scheduleMicrotask(() => print('task4'));
  }).then((_) => print("task5"));

  future.then((_) => print("task6"));
  scheduleMicrotask(() => print('task7'));

  Future(() => print('task8'))
    .then((_) => Future(() => print('task9')))
    .then((_) => print('task10'));

  print("main end");
}
```

```console
main start
main end
task7
task1
task6
task2
task3
task5
task4
task8
task9
task10
```

## 多核CPU的利用

每个 Isolate 都有自己的 Event Loop 与 Queue

Isolate 之间不共享任何资源，只能依靠消息机制通信，因此没有资源抢占问题。

### 创建Isolate

通过Isolate.spawn

```dart
import "dart:isolate";

main(List<String> args) {
  Isolate.spawn(foo, "Hello Isolate");
}

void foo(info) {
  print("新的isolate：$info");
}
```

### Isolate通信机制

我们不会只是简单的开启一个新的Isolate，而不关心它的运行结果：

我们需要新的Isolate进行计算，并且将计算结果告知Main Isolate（也就是默认开启的Isolate）；

Isolate 通过发送管道（SendPort）实现消息通信机制；

我们可以在启动并发Isolate时将Main Isolate的发送管道作为参数传递给它；

并发在执行完毕时，可以利用这个管道给Main Isolate发送消息；

```dart
import "dart:isolate";

main(List<String> args) async {
  // 1.创建管道
  ReceivePort receivePort= ReceivePort();

  // 2.创建新的Isolate
  Isolate isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);

  // 3.监听管道消息
  receivePort.listen((data) {
    print('Data：$data');
    // 不再使用时，我们会关闭管道
    receivePort.close();
    // 需要将isolate杀死
    isolate?.kill(priority: Isolate.immediate);
  });
}

void foo(SendPort sendPort) {
  sendPort.send("Hello World");
}
```

上面的通信变成了单向通信，如果需要双向通信呢？

事实上双向通信的代码会比较麻烦；

Flutter提供了支持并发计算的compute函数，它内部封装了Isolate的创建和双向通信；

以此可以充分利用多核心CPU

注意：以下代码非dart API，而是Flutter API

```dart
main(List<String> args) async {
  int result = await compute(powerNum, 5);
  print(result);
}

int powerNum(int num) {
  return num * num;
}
```
