import 'package:flutter/material.dart';

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
