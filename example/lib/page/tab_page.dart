import 'package:zeking_refresh_example/common/index_all.dart';

import 'my_refresh.dart';

class TabPage extends StatefulWidget {
  final String tag;

  const TabPage({Key key, this.tag}) : super(key: key);

  @override
  _GeneralMonthListState createState() => _GeneralMonthListState();
}

class _GeneralMonthListState extends State<TabPage> with AutomaticKeepAliveClientMixin {

  ZekingRefreshController _refreshController;
  @override
  void initState() {
    super.initState();

    _refreshController = new ZekingRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: MyRefresh(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        useScrollController: false, /// 和NestedScrollView使用，这边要设置false，不清楚的自行熟悉NestedScrollView的用法
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return buildItem(index);
          },
          itemCount: 2,
        ),
      ),
    );
  }

  Widget buildItem(index){

    return Column(
      children: <Widget>[
        Container(
          height: Dimens.size(111),
          color: Colors.red,
          alignment: Alignment.center,
          child: Text('$index'),
        ),
        Container(
          height: Dimens.size(111),
          alignment: Alignment.center,
          child: Text('$index'),
        ),
        DividerHorizontalMargin()
      ],

    );
  }

  ///================================= 网络请求 ===============================================

  void onRefresh() {
    print('onRefresh:'+widget.tag);
  }

  void onLoading() {
    print('onLoading:'+widget.tag);
  }

  @override
  bool get wantKeepAlive => true;
}
