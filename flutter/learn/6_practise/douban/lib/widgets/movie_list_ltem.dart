import 'package:douban/http/http_request.dart';
import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {
  final SearchSubject subject;

  MovieListItem(this.subject);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getMovieRankWidget(),
          SizedBox(
            height: 12,
          ),
          getMovieContentWidget(),
          SizedBox(
            height: 12,
          ),
          getMovieIntroWidget(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  /**
   * 排名Widget
   */
  Widget getMovieRankWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 238, 205, 144),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        "No. 1",
        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
      ),
    );
  }

  /**
   * 中间内容
   */
  Widget getMovieContentWidget() {
    return Container(
      child: Row(
        children: [
          getContentImage(),
          getContentDesc(),
          getDashLine(),
          getContentWish(),
        ],
      ),
    );
  }

  /**
   * 底部介绍Widget
   */
  Widget getMovieIntroWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        "简介",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget getContentImage() {
    return Container(
      // width: subject.coverX.toDouble() / 10,
      // height: subject.coverY.toDouble() / 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(subject.cover),
      ),
    );
  }

  Widget getContentDesc() {
    return Container();
  }

  Widget getDashLine() {
    return Container();
  }

  Widget getContentWish() {
    return Container();
  }
}
