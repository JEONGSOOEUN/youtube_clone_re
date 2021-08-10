import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone_re/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_clone_re/tab3.dart';

import 'api.dart';
import 'detailPage.dart';
import 'method.dart';
import 'tab2.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Soon2'),
          bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,

            // 탭바 가로 스크롤
            // isScrollable: true,

            // 탭바 하단 밑줄 투명으로
            indicatorColor: Colors.transparent,
            // indicatorSize: TabBarIndicatorSize.label,
            // indicatorColor: Colors.red,
            // indicatorWeight: 1,
            tabs: [
              Icon(Icons.home),
              Text('Tab2'),
              Text('Tab3')
            ],
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('search button is clicked');
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('https://mblogthumb-phinf.pstatic.net/20151204_76/tweety_zz_1449200290381yNY4h_PNG/%B4%DC%BA%F1.PNG?type=w2'),
                ),
                accountName: Text('수은'),
                accountEmail: Text('resee1221@naver.com'),
                onDetailsPressed: () {
                  print('arrow is clicked');
                },
                // decoration: BoxDecoration(
                //   color: Colors.red,
                //   borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(40.0),
                //   bottomRight: Radius.circular(40.0)
                //   )
                // ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  print('Home is clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting'),
                onTap: () {
                  print('Setting is clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('Q&A'),
                onTap: () {
                  print('Q&A is clicked');
                },
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ),
        body:
        TabBarView(
          // home
          children: [
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              onRefresh: _fetchPosts,
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: this._posts.length,
                  itemBuilder: (context, index) {
                  final post = this._posts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(_posts[index]),
                          )
                        );
                      },
                      child: Column(
                       children: [
                         Image.network('${post.thumbnail}',
                          height: 200,),
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
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Like : ${post.voted_count}',
                              style: TextStyle(fontSize: 12.0),),
                              Text('View : ${post.readed_count} ',
                                style: TextStyle(fontSize: 12.0),),
                            ]),
                         ]),
                         SizedBox(
                           height: 5.0,
                         ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${post.description.substring(0, 70)} ······.'),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Date : ' + readTimestamp(post.created_at.toInt()),
                               style: TextStyle(fontSize: 12.0),
                             ),
                        ]),
                         SizedBox(
                           height: 50.0,
                         )
                       ],
                      ),
                    );
                  },
                ),
             ),

            // Tab2
            Tab2(),
            // Tab3
            Tab3(),
          ],
        ),
      ),
    );
  }
}



