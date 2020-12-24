import 'package:douban/http/http_request.dart';
import 'package:douban/widgets/dashed_line.dart';
import 'package:douban/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        "No. ${subject.rank}",
        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
      ),
    );
  }

  /**
   * 中间内容
   */
  Widget getMovieContentWidget() {
    return Container(
      height: 150,
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
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        // clipBehavior:cli,
        child: Image.network(
          subject.cover,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget getContentDesc() {
    return Container(
      width: 210,
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.slow_motion_video_sharp,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Container(
                width: 150,
                child: Text(
                  subject.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              StarRating(
                rating: subject.rate,
                size: 20,
              ),
              Text(subject.rate.toString())
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text("喜剧 喜剧 演员 演员")
        ],
      ),
    );
  }

  Widget getDashLine() {
    return Container(
      child: DashedLine(
        axis: Axis.vertical,
        count: 40,
      ),
    );
  }

  Widget getContentWish() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      width: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.local_florist,
            color: Colors.orange,
          ),
          Text(
            "想看",
            style: TextStyle(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
