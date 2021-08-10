import 'dart:convert';
import 'package:http/http.dart' as http;

class getDummy{
  String host = 'http://dummy.amuz.co.kr';
  String dummy = '/';

}

Future<List<Post>> doApiGET(String action) async{

  var response =await http.get(getDummy().host+ action);
  var statusCode = response.statusCode;
  if(statusCode == 200) {

    // TODO : 리턴 오브젝트 내의 에러와 메세지를 다시 검사해야함.

    List<Post> parsedResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJSON(json))
        .toList();

    return parsedResponse;
  } else {
    throw Exception('Failed to load post');
  }
}

class Post  {
  final String title;
  final String thumbnail;
  final String avatar;
  final String description;
  final int readed_count;
  final int voted_count;
  final int created_at;

  Post(
      {required this.title, required this.thumbnail, required this.avatar, required this.description, required this.readed_count,
        required this.voted_count, required this.created_at});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
        title: json['title'],
        thumbnail: json['thumbnail'],
        avatar: json['avatar'],
        description: json['description'],
        readed_count: json['readed_count'],
        voted_count: json['voted_count'],
        created_at: json['created_at']
    );
  }
}