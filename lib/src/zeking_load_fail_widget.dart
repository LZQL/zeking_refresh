import 'package:flutter/material.dart';
import 'zeking_refresh.dart';

/// 加载更多，失败 widget
class ZekingLoadFailWidget extends StatefulWidget {
  final ZekingRefreshController controller;
  final String message;
  final Widget child;

  ZekingLoadFailWidget({@required this.controller, this.message,this.child});

  @override
  _ZekingLoadFailWidgetState createState() => _ZekingLoadFailWidgetState();
}

class _ZekingLoadFailWidgetState extends State<ZekingLoadFailWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.controller.requestLoading,
      child: widget.child ?? Container(
        height: 60,
//        height: Dimens.size(120),
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Center(
            child: Text(
              widget.message == null
                  ? '加载失败，请点击重试'
//              IntlUtil.getString(
//                      context, Ids.failed_to_load_please_click_retry)
                  : widget.message,
//              style: TextStyles.size28color666666,
              style: TextStyle(color: Color(0xff666666), fontSize: 14)
            ),
          ),
        ),
      ),
    );
  }
}
