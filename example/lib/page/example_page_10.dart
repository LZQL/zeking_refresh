import 'package:zeking_refresh_example/common/index_all.dart';
import 'package:zeking_refresh_example/widget/custom_sliver_app_bar_delegate.dart';

import 'tab_page.dart';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

/// 和 NestedScrollView 使用
class ExamplePage10 extends StatefulWidget {
  @override
  _ExamplePage10State createState() => _ExamplePage10State();
}

class _ExamplePage10State extends State<ExamplePage10>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> data;
  int addIndex = 1;
  ScrollController _scrollController;
  double indicatorPadding =
      SystemScreenUtil.getInstance().screenWidth / 4 - Dimens.size(35);

  PageController _pageController = PageController(initialPage: 0);
  var _isPageCanChanged = true;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
    data = new List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTitleBar(
        '和 NestedScrollView 使用 2',
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return extended.NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
//          SliverPersistentHeader(
//              pinned: true,
//              floating: true,
//              delegate: CustomSliverAppBarDelegate(
//                  minHeight: Dimens.size(111),
//                  maxHeight: Dimens.size(111),
//                  child: _buildTabTitle()))
        ];
      },
      innerScrollPositionKeyBuilder: () {
        if (_tabController.index == 0) {
          return Key('Tab0');
        } else {
          return Key('Tab1');
        }
      },
      body: _buildRankListPageView(),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: Dimens.size(400),
      color: Colors.red,
      alignment: Alignment.center,
      child: Text('我是头部'),
    );
  }

  Widget _buildTabTitle() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: Dimens.size(110),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.size(15)),
            child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }

                  _pageController.jumpToPage(index);
                },
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: ColorT.color_666666,
                labelStyle: TextStyle(
                    fontSize: Dimens.sp(32),
                    color: Theme.of(context).primaryColor),
                unselectedLabelStyle: TextStyles.size32color666666,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: Dimens.size(4),
                indicatorPadding: EdgeInsets.only(
                    left: indicatorPadding, right: indicatorPadding),
                tabs: <Widget>[
                  Tab(
                    child: Text('Tab1'),
                  ),
                  Tab(
                    child: Text('Tab2'),
                  )
                ]),
          ),
        ),
        DividerHorizontal(),
      ],
    );
  }

  Widget _buildRankListPageView() {
    return Column(
      children: <Widget>[
//        SliverPersistentHeader(
//            pinned: true,
//            floating: true,
//            delegate: CustomSliverAppBarDelegate(
//                minHeight: Dimens.size(111),
//                maxHeight: Dimens.size(111),
//                child: _buildTabTitle())),
        _buildTabTitle(),
        Expanded(
          child: PageView.builder(
            itemCount: 2,
            onPageChanged: (index) {
              if (_isPageCanChanged) {
                //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                _onPageChange(index);
              }
            },
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return extended.NestedScrollViewInnerScrollPositionKeyWidget(
                    Key('Tab0'),
                    TabPage(
                      tag: 'Tab1',
                    ));
              } else {
                return extended.NestedScrollViewInnerScrollPositionKeyWidget(
                    Key('Tab1'),
                    TabPage(
                      tag: 'Tab2',
                    ));
              }
            },
          ),
        ),
      ],
    );
  }

  _onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //判断是哪一个切换
      _isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      _isPageCanChanged = true;
    } else {
      _tabController.animateTo(index); //切换Tabbar
    }
  }

//  void onRefresh() {
//    print('onRefresh:'+widget.tag);
//  }
//
//  void onLoading() {
//    print('onLoading:'+widget.tag);
//  }
}
