import 'package:flutter/material.dart';

/// 加载更多   已加载全部数据 widget
class ZekingLoadNoMoreWidget extends StatefulWidget {
  final String message;
  final Widget child;

  ZekingLoadNoMoreWidget({this.message,this.child});

  @override
  _ZekingLoadNoMoreWidgetState createState() => _ZekingLoadNoMoreWidgetState();
}

class _ZekingLoadNoMoreWidgetState extends State<ZekingLoadNoMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container(
      height: 60,
//      height: Dimens.size(120),
      child: Center(
        child: Text(
          widget.message??
               '已加载全部数据',
          style: TextStyle(color: Color(0xff666666), fontSize: 14),
        ),
      ),
    );
  }
}
