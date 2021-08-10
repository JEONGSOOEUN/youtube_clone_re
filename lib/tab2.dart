import 'package:flutter/material.dart';

class Tab2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tab2',
                  style: TextStyle(
                      color: Colors.red,
                      letterSpacing: 2.0,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)
              )
            ]
        ),
      ),
    );
  }
}

