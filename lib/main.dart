import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SOON APP',
      theme: ThemeData.dark(),
      home: new HttpExampleWidget(),
    );
  }
}

class HttpExampleWidget extends StatefulWidget {
  @override
  _HttpExampleWidgetState createState() => _HttpExampleWidgetState();
}

class _HttpExampleWidgetState extends State<HttpExampleWidget> {
  List<Post> _posts = [];

  void _fetchPosts() async {
    final response =await http.get('http://dummy.amuz.co.kr/');
    final List<Post> parsedResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJSON(json))
        .toList();
    setState(() {
      _posts.clear();
      _posts.addAll(parsedResponse);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: this._posts.length,
          itemBuilder: (context, index) {
            final post = this._posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text('Id: ${post.title}  UserId: ${post.avatar}'),
            );
          },
        ),
      ),
    );
  }
}

class Post {
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