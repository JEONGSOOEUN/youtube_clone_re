import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone_re/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

import 'api.dart';

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
  List<Post> parsedResponse = (await doApiGET(getDummy().dummy)).cast<Post>();

    setState(() {
      _posts.clear();
      _posts.addAll(parsedResponse);
    });

    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _fetchPosts,
        child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: this._posts.length,
              itemBuilder: (context, index) {
                final post = this._posts[index];
                return Column(
                 children: [
                   Image.network('${post.thumbnail}',
                   fit: BoxFit.fill,),
                   SizedBox(
                     height: 10.0,
                   ),
                   Text('${post.title}',
                     style: TextStyle(fontSize: 15.0),),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                     CircleAvatar(
                       backgroundImage: NetworkImage('${post.avatar}'),
                     ),
                     SizedBox(
                       width: 10.0,
                     ),
                     Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('조회수 : ${post.readed_count}',
                        style: TextStyle(fontSize: 12.0),),
                      Text('게시일 : '+ readTimestamp(post.created_at.toInt()),
                      style: TextStyle(fontSize: 12.0),)
                      ]),
                   ]),
                   SizedBox(
                     height: 5.0,
                   ),
                   Text('${post.description}'),
                   SizedBox(
                     height: 20.0,
                   )
                 ],
                );
              },
            ),
      ),
      );
  }
}

String readTimestamp(int timestamp) {
  var origin = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String createDate = DateFormat('yyyy-MM-dd').format(origin);
  return createDate;
}

Widget _buildPost() {
  return Scaffold(

  );
}