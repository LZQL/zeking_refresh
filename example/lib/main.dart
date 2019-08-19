import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zeking_refresh/zeking_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ZekingRefreshController _refreshController;

  int i = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = new ZekingRefreshController();
    _refreshController.refreshEmpty();
  }

  @override
  Widget build(BuildContext context) {
//    BoxScrollView
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView(
        children: <Widget>[
          buildItem('1. 默认场景展示', (){}),
          buildItem('2. 自定义场景展示 widget', (){}),
          buildItem('3. 默认场景下动态改变 提示语 和 吐司提示', (){}),
          buildItem('4. 自定义场景下动态改变 提示语 和 吐司提示', (){}),
        ],
      ),
    ));
  }

  Widget buildItem(String title, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15),
            height: 50,
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: Color(0xff333333)),
            ),
          ),
          Container(color: Color(0xFFe5e5e5),width: double.infinity,height: 0.5,)
        ],

      ),
    );
  }
}
