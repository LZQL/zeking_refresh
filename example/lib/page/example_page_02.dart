import 'package:zeking_refresh_example/common/index_all.dart';

/// 配置默认场景UI展示
class ExamplePage02 extends StatefulWidget {
  @override
  _ExamplePage02State createState() => _ExamplePage02State();
}

class _ExamplePage02State extends State<ExamplePage02> {
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
        title: Text('配置默认场景UI展示'),
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
        refreshLoadingImagePath: 'images/common_loading.png', /// 配置默认的 刷新 加载中 的 图标
        refreshEmptyImagePath: 'images/empty.png',            /// 配置默认的 刷新 空数据 的 图标
        refreshEmptyMessage: '刷新后是空数据哦 - -。111',      /// 配置默认的 刷新 空数据 的 提示语
        refreshFailImagePath: 'images/failure.png',           /// 配置默认的 刷新 失败 的 图标
        refreshFailMessage: '刷新后是失败的哦 - -。222 ？',    /// 配置默认的 刷新 失败 的 提示语
        loadLoadingMessage: '正在加载啊 啊啊啊 333',           /// 配置默认的 刷新 失败 的 图标
        loadFailMessage: '我擦，居然加载失败了。要不再点我试试 4444', /// 配置默认的 加载更多 失败 的 提示语
        loadNoMoreMessage: '牛逼啊，这都被你翻到最后一页了。',        /// 配置默认的 加载更多 空数据 的 图标
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
