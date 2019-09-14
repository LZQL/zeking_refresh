import 'package:flutter/cupertino.dart';
import 'package:zeking_refresh_example/common/index_all.dart';

/// 自定义场景 下 动态改变 提示语 和 吐司提示
/// （配合 设置全局 场景UI 使用，懒得写Demo了，自己尝试 ）
/// 吐司提示 和 example_page_04 是一样的
/// 动态改变提示语  的话 ，因为你的  布局是自定义的，
/// 所以 你直接改变你传入的  下面这些 widget 就可以了。
//        refreshLoadingWidget: buildRefreshLoading(), /// 自定义 刷新 加载中 布局
//        refreshFailWidget: buildRefreshFaild(),      /// 自定义 刷新 失败 布局
//        refreshEmptyWidget: buildRefreshEmpty(),     /// 自定义 刷新 空数据 布局
//        loadLoadingWidget: buildLoadLoading(),       /// 自定义 加载更多 加载中 布局
//        loadFailWidget: buildLoadFaild(),            /// 自定义 加载更多 失败 布局
//        loadNoMoreWidget: buildLoadNoMore(),         /// 自定义 加载更多 已加载全部 布局
//        loadingWidget:
class ExamplePage06 extends StatefulWidget {
  @override
  _ExamplePage06State createState() => _ExamplePage06State();
}

class _ExamplePage06State extends State<ExamplePage06> {
  ZekingRefreshController _refreshController;

  List<String> data;
  int addIndex = 1;

  @override
  void initState() {
    data = new List();
    _refreshController = ZekingRefreshController();
    super.initState();

    /// 首次进去 加载数据 ，会自动调用 onRefresh 方法
    _refreshController.refreshingWithLoadingView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('默认场景动态改变提示语和吐司提示')),
      body: Text('''
自定义场景 下 动态改变 提示语 和 吐司提示

吐司提示 和 example_page_04 是一样的

动态改变提示语  的话 ，因为你的  布局是自定义的，

所以 你直接改变你传入的  下面这些 widget 就可以了。

        refreshLoadingWidget: buildRefreshLoading(), /// 自定义 刷新 加载中 布局
        refreshFailWidget: buildRefreshFaild(),      /// 自定义 刷新 失败 布局
        refreshEmptyWidget: buildRefreshEmpty(),     /// 自定义 刷新 空数据 布局
        loadLoadingWidget: buildLoadLoading(),       /// 自定义 加载更多 加载中 布局
        loadFailWidget: buildLoadFaild(),            /// 自定义 加载更多 失败 布局
        loadNoMoreWidget: buildLoadNoMore(),         /// 自定义 加载更多 已加载全部 布局
        loadingWidget:'),
   '''),
    );
  }
}
