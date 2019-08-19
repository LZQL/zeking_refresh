import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class ZekingLoadingWidget extends StatefulWidget {
  @override
  _ZekingLoadingWidgetState createState() => _ZekingLoadingWidgetState();
}

class _ZekingLoadingWidgetState extends State<ZekingLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:
//      CupertinoActivityIndicator(
//
////        radius: 60,//值越大  圆圈越大
//
//      )
      SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
//          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
      ),
    );
  }
}
