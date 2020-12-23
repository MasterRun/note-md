import 'package:flutter/material.dart';

import 'http/http_request.dart';
import 'widgets/movie_list_ltem.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: HomeContent(),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<SearchSubject> searchItems = [];

  @override
  void initState() {
    HttpRequest.searchMovie().then((value) {
      setState(() {
        searchItems.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchItems.length,
      itemBuilder: (context, index) {
        var searchItem = searchItems[index];
        searchItem.rank = index + 1;
        return MovieListItem(searchItem);
      },
    );
  }
}
