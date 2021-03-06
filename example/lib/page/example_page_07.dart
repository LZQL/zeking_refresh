import 'package:zeking_refresh_example/common/index_all.dart';

import 'my_refresh.dart';

/// 自定义 吐司 样式
class ExamplePage07 extends StatefulWidget {
  @override
  _ExamplePage07State createState() => _ExamplePage07State();
}

class _ExamplePage07State extends State<ExamplePage07> {
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
        title: Text('自定义 吐司 样式  为 弹框提示'),
        actions: <Widget>[
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.selectView('refreshingWithLoadingView', '1'),
              this.selectView('refreshEmpty 自定义吐司 样式', '2'),
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
                  _refreshController.refreshEmpty(toastMsg: '11111');
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
      body: MyRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        toastMethod: toastMethod,
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

  void toastMethod(msg){
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        msg,
        style: new TextStyle(fontSize: 30.0, color: Colors.red),
      ),
    );
    showDialog(context: context, child: dialog);
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
