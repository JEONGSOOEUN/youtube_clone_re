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
  String _text = '';

  void _fetchPosts() async {
    final response =await http.get('http://dummy.amuz.co.kr/');
    final List<Post> parsedResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJson(json))
        .toList();
    setState(() {
      
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
      appBar: AppBar(
        title: Text('SOON APP'),
      ),
      body: Center(
        child: Text(_text),
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

  Post({this.title, this.thumbnail, this.avatar, this.description, this.readed_count,
    this.voted_count, this.created_at});

  factory Post.fromJson(Map<String, dynamic> json) {
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