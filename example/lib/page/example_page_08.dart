import 'package:zeking_refresh_example/common/index_all.dart';

import 'package:zeking_refresh_example/widget/custom_sliver_app_bar_delegate.dart';
import 'my_refresh.dart';

/// 和 CustomScrollView 使用
class ExamplePage08 extends StatefulWidget {
  @override
  _ExamplePage08State createState() => _ExamplePage08State();
}

class _ExamplePage08State extends State<ExamplePage08> {
  ZekingRefreshController _refreshController;

  List<String> data;
  int addIndex = 1;

  @override
  void initState() {
    data = new List();
    _refreshController = ZekingRefreshController();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: MyRefresh(
            displacement: Dimens.size(200), /// 修改下拉刷新图标的 偏移量
            controller: _refreshController,
            onRefresh: onRefresh,
            canLoadMore: false,
            child: CustomScrollView(
              slivers: <Widget>[
                makeHeader('和 CustomScrollView 使用'),
                SliverToBoxAdapter(
                  child: Container(
                    height: Dimens.size(1000),
                    color: Colors.red,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: Dimens.size(1000),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /// 标题
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverAppBarDelegate(
          minHeight: Dimens.size(88) + SystemScreenUtil.getStatusBarH(context),
          maxHeight:  Dimens.size(88) + SystemScreenUtil.getStatusBarH(context),
          child: MyTitleBar(
            headerText,
            userThemeStyle: true,
            showDivider: false,
            dividerColor: Theme.of(context).primaryColor,
          )),
    );
  }


  void onRefresh() {
    print('onRefresh');
  }

  void onLoading() {
    print('onLoading');
  }
}
