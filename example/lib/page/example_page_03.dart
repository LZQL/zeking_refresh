import 'package:flutter/cupertino.dart';
import 'package:zeking_refresh_example/common/index_all.dart';

/// 自定义场景UI展示
class ExamplePage03 extends StatefulWidget {
  @override
  _ExamplePage03State createState() => _ExamplePage03State();
}

class _ExamplePage03State extends State<ExamplePage03> {
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
      appBar: AppBar(
        title: Text('自定义场景UI展示'),
        actions: <Widget>[
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.selectView('refreshingWithLoadingView', '1'),
              this.selectView('refreshEmpty', '2'),
              this.selectView('refreshFaild', '3'),
              this.selectView('loading', '4'),
              this.selectView('loadingEnd', '5'),
              this.selectView('loadMoreFailed', '6'),
              this.selectView('loadMoreNoMore', '7'),
            ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case '1':
                  _refreshController.refreshingWithLoadingView();
                  break;
                case '2':
                  _refreshController.refreshEmpty();
                  break;
                case '3':
                  _refreshController.refreshFaild();
                  break;
                case '4':
                  _refreshController.loading();
                  break;
                case '5':
                  _refreshController.loadingEnd();
                  break;
                case '6':
                  _refreshController.loadMoreFailed();
                  break;
                case '7':
                  _refreshController.loadMoreNoMore();
                  break;
              }
            },
          )
        ],
      ),
      body: ZekingRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        refreshLoadingWidget: buildRefreshLoading(), /// 自定义 刷新 加载中 布局
        refreshFailWidget: buildRefreshFaild(),      /// 自定义 刷新 失败 布局
        refreshEmptyWidget: buildRefreshEmpty(),     /// 自定义 刷新 空数据 布局
        loadLoadingWidget: buildLoadLoading(),       /// 自定义 加载更多 加载中 布局
        loadFailWidget: buildLoadFaild(),            /// 自定义 加载更多 失败 布局
        loadNoMoreWidget: buildLoadNoMore(),         /// 自定义 加载更多 已加载全部 布局
        loadingWidget: buildLoading(),               /// 自定义 逻辑加载中  布局
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            return ItemWidget(data[index], () {});
          },
          itemCount: data.length,
        ),
      ),
    );
  }

  /// 刷新 加载中 布局
  Widget buildRefreshLoading(){
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text('自定义刷新加载中布局 --》 11'),
      ),
    );
  }

  /// 刷新 失败 布局
  /// 需要注意的是，因为该布局默认有一个点击事件，
  /// 所以该布局有效范围多大，你的点击范围就多大
  Widget buildRefreshFaild(){
    return Container(
      color: Colors.red,
      child: Center(
        child: Text('22 《--自定义刷新 失败 布局 --》 22'),
      ),
    );
  }

  /// 刷新 空数据 布局
  /// 需要注意的是，因为该布局默认有一个点击事件，
  /// 所以该布局有效范围多大，你的点击范围就多大
  Widget buildRefreshEmpty(){
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('33 《-- 自定义刷新 空数据 布局 --》 33'),
      ),
    );
  }

  Widget buildLoadLoading(){
    return Container(
      color: Colors.orange,
      height: 50,
      alignment: Alignment.center,
      child: Text('自定义 加载更多，  加载中  布局'),
    );
  }

  Widget buildLoadFaild(){
    return Container(
      color: Colors.pink,
      height: 50,
      alignment: Alignment.center,
      child: Text('自定义 加载更多，  失败  布局'),
    );
  }

  /// 自定义 加载更多 已加载全部 布局
  Widget buildLoadNoMore(){
    return Container(
      color: Colors.yellow,
      height: 50,
      alignment: Alignment.center,
      child: Text('自定义 加载更多，  已加载全部数据  布局'),
    );
  }

  /// 自定义 逻辑加载中  布局
  Widget buildLoading(){
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20,//值越大  圆圈越大

      ),
    );
  }


  // 返回每个隐藏的菜单项
  Widget selectView(String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
//            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        ));
  }

  void onRefresh() {
    print('onRefresh');
    Future.delayed(Duration(seconds: 3), () {
      if(data.length !=0){
        data.clear();
      }
      for (int i = 0; i < 20; i++) {
        data.add('index:${i}');
      }
      setState(() {});
      _refreshController.refreshSuccess();
    });
  }

  void onLoading() {
    print('onLoading');
    Future.delayed(Duration(seconds: 3), () {
      for (int i = (addIndex - 1) * 20; i < 20 * addIndex; i++) {
        data.add('add index:${i}');
      }
      addIndex += 1;
      setState(() {});
      _refreshController.loadMoreSuccess(toastMsg:'load more success');
    });

  }
}
