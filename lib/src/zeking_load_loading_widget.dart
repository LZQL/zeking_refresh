import 'package:flutter/material.dart';


/// 加载更多  加载中 widget
class ZekingLoadLoadingWidget extends StatefulWidget {
  final String message;
  final Widget child;

  ZekingLoadLoadingWidget({this.message,this.child});

  @override
  _ZekingLoadLoadingWidgetState createState() =>
      _ZekingLoadLoadingWidgetState();
}

class _ZekingLoadLoadingWidgetState extends State<ZekingLoadLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? Center(
      child: Container(
        height: 60,
//        height: Dimens.size(120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
//                valueColor: AlwaysStoppedAnimation(ColorT.gray_66),
              ),
            ),
            Container(
              width: 15,
            ),
            Text(
              widget.message ?? '正在加载更多数据',
              style: TextStyle(color: Color(0xff666666), fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
