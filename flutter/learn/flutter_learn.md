# Flutter

`flutter create learn_flutter`

HelloWorld:

```dart
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(Text("Hello World", textDirection: TextDirection.ltr));
}
```

`runApp(Widget app` 启动flutter 应用程序

Flutter中万物皆Widget

material脚手架:

```dart
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(
    MaterialApp(
      //脚手架
      home: Scaffold(
        appBar: AppBar(
          title: Text("CODERWHY"),
        ),
        body: Center(
          child: Text(
            "Hello World",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 36),
          ),
        ),
      ),
    )
  );
}
```

- StatelessWidget： 没有状态改变的Widget，通常这种Widget仅仅是做一些展示工作而已；
- StatefulWidget： 需要保存状态，并且可能出现状态改变的Widget

**build方法被执行：**
1、StatelessWidget第一次被插入到Widget树中时（第一次被创建时）；
2、父Widget（parent widget）发生改变时，子Widget会被重新构建；
3、如果Widget依赖InheritedWidget的一些数据，InheritedWidget数据发生改变时

SizedBox设置height属性，可用于占位

一旦Widget中展示的数据发生变化，就重新构建整个Widget

```dart
@immutable
abstract class Widget extends DiagnosticableTree {
    // ...省略代码
}
```

被@immutable注解标明的类或者子类都必须是不可变的

**结论**： 定义到Widget中的数据一定是不可变的，需要使用final来修饰

创建StatefulWidget时必须创建两个类：

- 一个类继承自StatefulWidget，作为Widget树的一部分；
- 一个类继承自State，用于记录StatefulWidget会变化的状态，并且根据状态的变化，构建出新的Widget

如下：
当Flutter在构建Widget Tree时，会获取State的实例，并且它调用build方法去获取StatefulWidget希望构建的Widget；
那么，我们就可以将需要保存的状态保存在MyState中，因为它是可变的

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 将创建的State返回
    return MyState();
  }
}

class MyState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return <构建自己的Widget>;
  }
}
```

**只要数据改变了Widget就需要重新构建（rebuild）**

