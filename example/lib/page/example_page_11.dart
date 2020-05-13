import 'package:zeking_refresh_example/common/index_all.dart';
import 'package:zeking_refresh_example/widget/custom_sliver_app_bar.dart';
import 'package:zeking_refresh_example/widget/custom_sliver_app_bar_delegate.dart';

import 'tab_page.dart';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

/// 和 NestedScrollView 使用
class ExamplePage11 extends StatefulWidget {
  @override
  _ExamplePage11State createState() => _ExamplePage11State();
}

class _ExamplePage11State extends State<ExamplePage11>
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
//      appBar: MyTitleBar(
//        '和 NestedScrollView 使用 3',
//      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight =
    //statusBar height
    statusBarHeight +
        //pinned SliverAppBar height in header
        40;

    return extended.NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // 自定义 SliverAppBar 高度 ，更符合实际生产需求
          CustomSliverAppBar(
            title: Text('和 NestedScrollView 使用 3'),
            expandedHeight: 200,
            minHeight: 40,
            leading: GestureDetector(
              child: Container(
                color: Colors.transparent,
                height: Dimens.size(87),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimens.size(34),
                    right: Dimens.size(32),
                  ),
                  child: Image.asset(
                    ImageUtil.getImgPath('back'),
                    width:  Dimens.size(20),
                    height:  Dimens.size(36),
                    color: ColorT.color_333333,
                  ),
                ),
              ),
              onTap: () {
                    Navigator.pop(context);
                  },
            ),
            background: Container(child: Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589285061459&di=00362c1624867c43fa1f1be113d6d2b5&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201709%2F10%2F20170910110429_5J8jt.jpeg',fit: BoxFit.cover,)),
          ),
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
        ];
      },
      pinnedHeaderSliverHeightBuilder: (){
        return pinnedHeaderHeight;
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
