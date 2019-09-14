import 'package:zeking_refresh_example/common/index_all.dart';

import 'my_refresh.dart';

/// 默认场景 下 动态改变 提示语 和 吐司提示
/// （配合 设置全局 场景UI 使用，懒得写Demo了，自己尝试 ）
class ExamplePage05 extends StatefulWidget {
  @override
  _ExamplePage05State createState() => _ExamplePage05State();
}

class _ExamplePage05State extends State<ExamplePage05> {
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
        title: Text('默认场景动态改变提示语和吐司提示'),
        actions: <Widget>[
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.selectView('1. refreshingWithLoadingView', '1'),
              this.selectView('2. refreshEmpty', '2'),
              this.selectView('2.1 refreshEmpty 动态改变 提示语', '2.1'),
              this.selectView('2.2 refreshEmpty 弹吐司', '2.2'),
              this.selectView('3. refreshFaild', '3'),
              this.selectView('3.1 refreshFaild 动态改变 提示语', '3.1'),
              this.selectView('3.2 refreshFaild 弹吐司', '3.2'),
              this.selectView('4. loading', '4'),
              this.selectView('5. loadingEnd', '5'),
              this.selectView('5.1 loadingEnd 弹吐司', '5.1'),
              this.selectView('6. loadMoreFailed', '6'),
              this.selectView('6.1 loadMoreFailed 动态改变 提示语', '6.1'),
              this.selectView('6.2 loadMoreFailed 弹吐司', '6.2'),
              this.selectView('7. loadMoreNoMore', '7'),
              this.selectView('7.1 loadMoreNoMore 动态改变 提示语', '7.1'),
              this.selectView('7.2 loadMoreNoMore 弹吐司', '7.2'),
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
                case '2.1':
                  _refreshController.refreshEmpty(uiMsg: '刷新 空数据 动态改变 -》 2.1');
                  break;
                case '2.2':
                  _refreshController.refreshEmpty(toastMsg: '刷新空数据 2.2 ');
                  break;
                case '3':
                  _refreshController.refreshFaild();
                  break;
                case '3.1':
                  _refreshController.refreshFaild(uiMsg: '刷新 失败 动态改变 -》 3.1');
                  break;
                case '3.2':
                  _refreshController.refreshFaild(toastMsg: '刷新空数据 3.2 ');
                  break;
                case '4':
                  _refreshController.loading();
                  break;
                case '5':
                  _refreshController.loadingEnd();
                  break;
                case '5.1':
                  _refreshController.loadingEnd(toastMsg: '请求数据结束 -》 5.1');
                  break;
                case '6':
                  _refreshController.loadMoreFailed();
                  break;
                case '6.1':
                  _refreshController.loadMoreFailed(uiMsg: '加载更多 失败 -》 6.1');
                  break;
                case '6.2':
                  _refreshController.loadMoreFailed(toastMsg: '加载更多 失败 -》6.2');
                  break;
                case '7':
                  _refreshController.loadMoreNoMore();
                  break;
                case '7.1':
                  _refreshController.loadMoreNoMore(uiMsg: '加载更多 已加载全部数据 -》 7.1');
                  break;
                case '7.2':
                  _refreshController.loadMoreNoMore(toastMsg: '加载更多 已加载全部数据 -》7.2');
                  break;
              }
            },
          )
        ],
      ),
      body: MyRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
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

  // 返回每个隐藏的菜单项
  Widget selectView(String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//            new Icon(icon, color: Colors.blue),
            new Text(text,style: TextStyle(fontSize: 13),),
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
