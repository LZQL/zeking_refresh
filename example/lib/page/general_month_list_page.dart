import 'package:zeking_refresh_example/common/index_all.dart';

import 'my_refresh.dart';

class TabPage extends StatefulWidget {

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
        useScrollController: false,
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return buildItem(index);
          },
          itemCount: 30,
        ),
      ),
    );
  }

  Widget buildItem(index){

    return Column(
      children: <Widget>[
        Container(
          height: Dimens.size(100),
          alignment: Alignment.center,
          child: Text('$index'),
        ),
        DividerHorizontalMargin()
      ],

    );
  }

  ///================================= 网络请求 ===============================================

  void onRefresh() {
    print('onRefresh');
  }

  void onLoading() {
    print('onLoading');
  }

  @override
  bool get wantKeepAlive => true;
}
