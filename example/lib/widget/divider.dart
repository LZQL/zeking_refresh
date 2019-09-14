import 'package:flutter/material.dart';
import 'package:zeking_refresh_example/common/index_all.dart';

/// 垂直的 分割线
class DividerVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.size(1),
      color: ColorT.divider,
    );
  }
}

/// 垂直的 分割线
class DividerVerticalMargin extends StatelessWidget {
  final double marginTop;

  final double marginBottom;

  DividerVerticalMargin({this.marginTop, this.marginBottom});

  @override
  Widget build(BuildContext context) {
    double top = marginTop ?? Dimens.size(20);
    double bottom = marginBottom ?? Dimens.size(20);
    return Container(
      width: Dimens.size(1),
      color: ColorT.divider,
      child: Container(
        padding: EdgeInsets.only(top: top, bottom: bottom),
      ),
    );
  }
}

/// 水平的 分割线
class DividerHorizontal extends StatelessWidget {
  final Color dividerColor;

  DividerHorizontal({this.dividerColor = ColorT.divider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.size(1),
      color: dividerColor,
    );
  }
}

/// 水平的 分割线
class DividerHorizontalMargin extends StatelessWidget {
  final double marginLeft;

  final double marginRight;

  DividerHorizontalMargin({this.marginLeft, this.marginRight});

  @override
  Widget build(BuildContext context) {
    double left = marginLeft ?? Dimens.size(32);
    double right = marginRight ?? Dimens.size(32);
    return Container(
      height: Dimens.size(1),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: Container(
          height: Dimens.size(1),
          color: ColorT.divider,
        ),
      ),
    );
  }
}
