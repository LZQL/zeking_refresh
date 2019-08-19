import 'package:flutter/material.dart';
import 'zeking_refresh.dart';

/// 下拉刷新数据 失败  widget
class ZekingRefreshFailWidget extends StatefulWidget {
  final ZekingRefreshController controller;
  final String imagePath;
  final double imageWith;
  final double imageHeight;
  final double centerPadding;
  final String message;
  final Widget child;

  ZekingRefreshFailWidget(
      {this.controller,
      this.message,
      this.child,
      this.imagePath,
      this.imageWith,
      this.imageHeight,
      this.centerPadding});

  @override
  _ZekingRefreshFailWidgetState createState() =>
      _ZekingRefreshFailWidgetState();
}

class _ZekingRefreshFailWidgetState extends State<ZekingRefreshFailWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.controller.refreshingWithLoadingView,
      child: widget.child ??
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.imagePath != null
                      ? Image.asset(
                          widget.imagePath,
                          width: widget.imageWith ?? 136,
                          height: widget.imageHeight ?? 122,
                        )
                      : Container(),
                  widget.imagePath != null
                      ? SizedBox(
                          height: widget.centerPadding ?? 36,
                        )
                      : Container(),
                  Text(
                    widget.message == null ? '加载失败，请点击屏幕重试' : widget.message,
                    style: TextStyle(color: Color(0xff666666), fontSize: 14),
                  )
                ],
              ),
            ),
          ),
    );

//      Center(
//      child: Container(
//          height: 60,
//          child: Text(
//            '加载失败，请点击重试',
//            style: TextStyle(color: ColorT.gray_66, fontSize: 14),
//          )),
//    );
  }
}
