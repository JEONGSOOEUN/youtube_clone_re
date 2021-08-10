import 'package:flutter/material.dart';
import 'api.dart';


class DetailPage extends StatelessWidget {

  final Post post;

  DetailPage(this.post);

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Center(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Image.network('${post.thumbnail}',
                  fit: BoxFit.fill,),
                Text(post.description,
                  style: TextStyle(
                    fontSize: 17.0
                ),)
              ],
            ),
          ])
        ),
      ),
    );
  }
}