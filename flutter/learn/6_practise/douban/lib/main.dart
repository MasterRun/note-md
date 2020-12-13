import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            StarRating(rating: 5.6),
            DashedLine(axis: Axis.vertical,count:40)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final int count;
  final Color color;

  DashedLine(
      {@required this.axis,
      this.dashedWidth = 1,
      this.dashedHeight = 1,
      this.count,
      this.color = const Color(0xffff0000)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //根据宽度计算个数
        return Flex(
          direction: this.axis,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(this.count, (index) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class StarRating extends StatefulWidget {
  //当前评分
  final double rating;
  //最高评分
  final double maxRating;
  final Widget unselectImage;
  final Widget selecetdImage;
  //展示星星的个数
  final int count;
  //星星的大小
  final double size;
  final Color unselectedColor;
  final Color selectedColor;

  StarRating({
    @required this.rating,
    this.maxRating = 10,
    this.size = 60,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffe0aa46),
    Widget unselectedImage,
    Widget selectedImage,
    this.count = 5,
  })  : unselectImage = unselectedImage ??
            Icon(
              Icons.star,
              size: size,
              color: unselectedColor,
            ),
        selecetdImage = selectedImage ??
            Icon(
              Icons.star,
              size: size,
              color: selectedColor,
            );

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Row(children: getUnSelectedImage(), mainAxisSize: MainAxisSize.min),
        Row(children: getSelectedImage(), mainAxisSize: MainAxisSize.min),
      ]),
    );
  }

  List<Widget> getUnSelectedImage() {
    // List<Widget> widgets = [];
    // widgets.add(widget.unselectImage);
    // return widgets;
    return List.generate(widget.count, (index) => widget.unselectImage);
  }

  List<Widget> getSelectedImage() {
    //每个的值
    double perValue = widget.maxRating / widget.count;
    //完整的个数
    var entireCount = (widget.rating / perValue).floor();
    //去掉完整的，剩余值
    double leftValue = widget.rating - entireCount * perValue;
    //剩余的值需要显示的比例
    double ratio = leftValue / perValue;

    List<Widget> selectedImages = [];
    for (int i = 0; i < entireCount; i++) {
      selectedImages.add(widget.selecetdImage);
    }

    Widget leftWidget = ClipRect(
      clipper: MyRectClipper(width: ratio * widget.size),
      child: widget.selecetdImage,
    );
    selectedImages.add(leftWidget);

    return selectedImages;
  }
}

/*
 * 自定义裁剪
 */
class MyRectClipper extends CustomClipper<Rect> {
  final double width;

  MyRectClipper({this.width});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(MyRectClipper oldClipper) => width != (oldClipper.width);
}
