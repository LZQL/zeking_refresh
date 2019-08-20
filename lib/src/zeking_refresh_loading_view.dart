import 'package:flutter/material.dart';

/// 加载中 动画 控件

class ZekingRefreshLoadingView extends StatefulWidget {
  final Widget child;
  final String imagePath;


  ZekingRefreshLoadingView({Key key, this.child, this.imagePath})
      : super(key: key);

  @override
  _ZekingRefreshLoadingViewState createState() =>
      _ZekingRefreshLoadingViewState();
}

class _ZekingRefreshLoadingViewState extends State<ZekingRefreshLoadingView>
    with TickerProviderStateMixin {
  AnimationController controller; //动画控制器
  CurvedAnimation curved;

  @override
  void initState() {
    super.initState();

    if (widget.child == null && widget.imagePath != null) {
      controller = new AnimationController(
          vsync: this, duration: const Duration(seconds: 1));
      curved = new CurvedAnimation(parent: controller, curve: Curves.linear);

      controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ??
        Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: widget.imagePath != null
              ? RotationTransition(
                  //旋转动画
                  turns: curved,
                  child: Image.asset(
                    widget.imagePath,
                    width: 30,
                    height: 30,
                  ))
              : SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
        );
  }

  @override
  void dispose() {
    if(controller!=null){
      controller.dispose();
    }
    super.dispose();
  }
}
