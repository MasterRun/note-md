import 'package:dio/dio.dart';

class HttpRequest {
  //创建实例对象
  static BaseOptions baseOptions = BaseOptions();
  static Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url,
      {String method = 'get', Map<String, dynamic> params}) async {
    Options options = Options();
    options.method = method;

    try {
      var response =
          await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      print("dio error: ${e.message}");
      // throw e;
    } catch (e) {
      print("error: :${e.message}");
    }
  }

  static Future<List<SearchSubject>> searchMovie(
      {String type = "tv",
      String tag = "热门",
      int start = 0,
      int count = 50}) async {
    final url =
        "https://movie.douban.com/j/search_subjects?type=${type}&tag=${tag}&page_limit=${count}&page_start=${start}";

    final result = await request(url);

    final subjects = result['subjects'];
    List<SearchSubject> searchSubjects = [];
    for (var sub in subjects) {
      searchSubjects.add(SearchSubject.fromMap(sub));
    }
    searchSubjects.sort((a, b) {
      return a.rate.compareTo(b.rate);
    });
    return searchSubjects;
  }
}

class SearchSubject {
  double rate;
  int coverX;
  int coverY;
  String title;
  String url;
  String cover;
  String id;
  bool isNew;
  bool playable;
  int rank;

  SearchSubject.fromMap(Map<String, dynamic> map) {
    this.rate = double.tryParse(map['rate']) ?? 0;
    this.coverX = map['cover_x'];
    this.coverY = map['cover_y'];
    this.title = map['title'];
    this.url = map['url'];
    this.cover = map['cover'];
    this.id = map['id'];
    this.isNew = map['is_new'];
    this.playable = map['playable'];
  }
}
