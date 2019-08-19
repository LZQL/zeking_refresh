import 'package:flutter/material.dart';
import 'zeking_refresh.dart';

/// 下拉刷新 成功  但是  无数据 页面
class ZekingRefreshEmptyWidget extends StatefulWidget {
  final ZekingRefreshController controller;
  final String message;

  final Widget child;

  final String imagePath;
  final double imageWith;
  final double imageHeight;
  final double centerPadding;

  ZekingRefreshEmptyWidget(
      {@required this.controller,
      this.message,
      this.child,
      this.imagePath,
      this.imageWith,
      this.imageHeight,
      this.centerPadding});

  @override
  _ZekingRefreshEmptyWidgetState createState() =>
      _ZekingRefreshEmptyWidgetState();
}

class _ZekingRefreshEmptyWidgetState extends State<ZekingRefreshEmptyWidget> {
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
                    widget.message == null ? '暂无数据，请点击屏幕重试' : widget.message,
                    style: TextStyle(color: Color(0xff666666), fontSize: 14),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
