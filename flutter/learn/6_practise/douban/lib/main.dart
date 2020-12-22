import 'package:flutter/material.dart';

import 'home.dart';
import 'widgets/dashed_line.dart';
import 'widgets/star_rating.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '豆瓣',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeWidget(),
          subject(),
          group(),
          mail(),
          profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: [
          createItem("首页"),
          createItem("书影院"),
          createItem("小组"),
          createItem("市集"),
          createItem("我的"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget subject() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StarRating(rating: 5.6),
          DashedLine(axis: Axis.vertical, count: 40)
        ],
      ),
    );
  }

  Widget group() {
    return Container(
      alignment: Alignment.center,
      child: Text("group"),
    );
  }

  Widget mail() {
    return Text("mail");
  }

  Widget profile() {
    return Text("profile");
  }

  BottomNavigationBarItem createItem(String title) {
    return BottomNavigationBarItem(
      icon: Icon(Icons.night_shelter),
      label: title,
    );
  }
}
