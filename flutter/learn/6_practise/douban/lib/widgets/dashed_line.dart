import 'package:flutter/material.dart';

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
