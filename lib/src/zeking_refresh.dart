import 'package:flutter/material.dart';

import 'zeking_refresh_loading_view.dart';
import 'zeking_refresh_empty_widget.dart';
import 'zeking_refresh_fail_widget.dart';
import 'zeking_load_loading_widget.dart';
import 'zeking_load_fail_widget.dart';
import 'zeking_load_no_more_widget.dart';
import 'zeking_loading_widget.dart';

import 'zeking_refresh_physics.dart';
import 'zeking_refresh_indicator.dart';

import 'utils/zeking_toast_util.dart';

typedef OnRefresh = Future<void> Function();

/// 下拉刷新状态
enum ZekingRefreshStatus {
  IDLE, // 闲置
//  REFRESHING,
//  DONE,
  Refreshing_LoadingView,
  Refreshing_LoadingView_ing,
  Refreshing,
  Refresh_Success,
  Refresh_Faild,
  Refresh_Faild_With_Toast,
  Refresh_Empty,
  LoadMoreing,
  LoadMoreing_ing,
  LoadMore_Success,
  LoadMore_Faild,
  LoadMore_NoMore,

//  LoadingEndWithToast
}

/// 业务 loading 状态
enum ZekingLoadingStatus {
  IDLE,
  Loading,
  LoadingEnd,
}

class ZekingRefresh extends StatefulWidget {
  final ZekingRefreshController controller;
  final Function onRefresh; // 下拉刷新回调,
  final Function onLoading; // 加载更多回调
  final Widget child;
  final double displacement;
  final bool canLoadMore; // 是否支持加载更多操作,默认支持
  final ScrollController scrollController;
  final bool canRefresh; // 是否支持下拉刷新操作，默认支持

  final ScrollPhysics physics;
  final bool useScrollController; // 是否自动绑定scrollController

  // 刷新 加载中 widget
  final Widget refreshLoadingWidget;
  final String refreshLoadingImagePath;

  // 刷新 空数据 widget
  final Widget refreshEmptyWidget;
  final String refreshEmptyMessage;
  final String refreshEmptyImagePath;
  final double refreshEmptyImageWidth;
  final double refreshEmptyImageHeight;
  final double refreshEmptyCenterPadding;

  // 刷新 失败 widget
  final Widget refreshFailWidget;
  final String refreshFailMessage;
  final String refreshFailImagePath;
  final double refreshFailImageWidth;
  final double refreshFailImageHeight;
  final double refreshFailCenterPadding;

  // 加载更多 加载中  widget
  final Widget loadLoadingWidget;
  final String loadLoadingMessage;

  // 加载更多 失败 widget
  final Widget loadFailWidget;
  final String loadFailMessage;

  // 加载更多 已加载全部数据 widget
  final Widget loadNoMoreWidget;
  final String loadNoMoreMessage;

  // 加载中 widget （一般用户，事件的操作，比如 登录，上传数据，提交等操作场景）
  final Widget loadingWidget;

  final Function toastMethod; // 支持 自定义 吐司

  ZekingRefresh(
      {@required this.controller,
      this.onRefresh,
      this.onLoading,
      this.child,
      this.displacement,
      this.canLoadMore = true,
      this.canRefresh = true,
      this.scrollController,
      this.physics,
      this.useScrollController = true,
      this.refreshLoadingWidget,
      this.refreshLoadingImagePath,
      this.refreshEmptyWidget,
      this.refreshEmptyMessage,
      this.refreshEmptyImagePath,
      this.refreshEmptyImageWidth,
      this.refreshEmptyImageHeight,
      this.refreshEmptyCenterPadding,
      this.refreshFailWidget,
      this.refreshFailMessage,
      this.refreshFailImagePath,
      this.refreshFailImageWidth,
      this.refreshFailImageHeight,
      this.refreshFailCenterPadding,
      this.loadLoadingWidget,
      this.loadLoadingMessage,
      this.loadFailWidget,
      this.loadFailMessage,
      this.loadNoMoreWidget,
      this.loadNoMoreMessage,
      this.loadingWidget,
      this.toastMethod});

  @override
  _ZekingRefreshState createState() => _ZekingRefreshState();
}

class _ZekingRefreshState extends State<ZekingRefresh> {
  ScrollController _scrollController;

  Widget refreshLoadingWidget;
  Widget refreshEmptyWidget;
  Widget refreshFailWidget;
  Widget loadLoadingWidget;
  Widget loadFailWidget;
  Widget loadNoMoreWidget;
  Widget loadingWidget;

  @override
  void initState() {
    super.initState();

    if (widget.canRefresh) {
      assert(widget.onRefresh != null);
    }

    if (widget.canLoadMore) {
      assert(widget.onLoading != null);
    }

    /// 状态改变监听
    widget.controller.refreshMode.addListener(_handleRefreshValueChanged);
    widget.controller.loadingMode.addListener(_handleLoadingValueChanged);

    if (widget.useScrollController) {
      if (widget.scrollController == null) {
        _scrollController = widget.child is ScrollView &&
                (widget.child as ScrollView).controller != null
            ? (widget.child as ScrollView).controller
            : new ScrollController();
      } else {
        _scrollController = widget.scrollController;
      }
    }

    if (widget.canLoadMore && widget.useScrollController) {
      /// 监听滚动事件
      _scrollController.addListener(() {
        // 如果滚动到底部
        if (_scrollController.position.maxScrollExtent ==
            (_scrollController.position.pixels)) {
          tryLoadMore();
        }
      });
    }
  }

  void _handleLoadingValueChanged() {
    // 业务逻辑 加载中 结束
    if (widget.controller.loadingMode.value == ZekingLoadingStatus.LoadingEnd) {
      if (widget.controller._loadingEndWithToastMessage.value != null &&
          widget.controller._loadingEndWithToastMessage.value != '') {
        if (widget.toastMethod == null) {
          ZekingToastUtil.showShort(
              widget.controller._loadingEndWithToastMessage.value, context);
        } else {
          widget
              .toastMethod(widget.controller._loadingEndWithToastMessage.value);
        }
      }
    }

    setState(() {});
  }

  void _handleRefreshValueChanged() {
    // 如果是 RefreshLoadingView  调用 刷新方法
//    if (widget.controller.refreshMode.value ==
//        ZekingRefreshStatus.Refreshing_LoadingView) {
//      widget.onRefresh();
//    }

    if (widget.canLoadMore) {
      // 如果是 LoadMoreing  调用 加载更多方法
      if (widget.controller.refreshMode.value ==
          ZekingRefreshStatus.LoadMoreing) {
        widget.controller.refreshMode.value =
            ZekingRefreshStatus.LoadMoreing_ing;
        widget.onLoading();
      }
    }

    /// 下面主要是 谈 吐司的 逻辑

    // 下拉刷新
    if (widget.controller.refreshMode.value ==
            ZekingRefreshStatus.Refresh_Success ||
        widget.controller.refreshMode.value ==
            ZekingRefreshStatus.Refresh_Faild ||
        widget.controller.refreshMode.value ==
            ZekingRefreshStatus.Refresh_Empty) {
      if (widget.controller._refreshEndWithToastMessage.value != null &&
          widget.controller._refreshEndWithToastMessage.value != '') {
        if (widget.toastMethod == null) {
          ZekingToastUtil.showShort(
              widget.controller._refreshEndWithToastMessage.value, context);
        } else {
          widget
              .toastMethod(widget.controller._refreshEndWithToastMessage.value);
        }
      }
    }

    // 加载更多
    if (widget.controller.refreshMode.value ==
            ZekingRefreshStatus.LoadMore_Faild ||
        widget.controller.refreshMode.value ==
            ZekingRefreshStatus.LoadMore_NoMore ||
        widget.controller.refreshMode.value ==
            ZekingRefreshStatus.LoadMore_Success) {
      if (widget.controller._loadMoreEndWithToastMessage.value != null &&
          widget.controller._loadMoreEndWithToastMessage.value != '') {
        if (widget.toastMethod == null) {
          ZekingToastUtil.showShort(
              widget.controller._loadMoreEndWithToastMessage.value, context);
        } else {
          widget.toastMethod(
              widget.controller._loadMoreEndWithToastMessage.value);
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /// ======================== 初始化 刷新 加载中 widget ========================

    if (widget.refreshLoadingWidget == null) {
      refreshLoadingWidget = ZekingRefreshLoadingView(
        imagePath: widget.refreshLoadingImagePath,
      );
    } else {
      refreshLoadingWidget = ZekingRefreshLoadingView(
        child: widget.refreshLoadingWidget,
      );
    }

    // 这个是刷新加载中的中间状态，为了防止多次调用onRefresh方法，
    //（已知道情况，一个页面刚进来的时候同时调用多个接口，配合Bloc的情况下）
    if (widget.controller.refreshMode.value ==
        ZekingRefreshStatus.Refreshing_LoadingView_ing) {
      return refreshLoadingWidget;
    }

    // 刷新 加载中
    if (widget.controller.refreshMode.value ==
        ZekingRefreshStatus.Refreshing_LoadingView) {
      widget.onRefresh();
      widget.controller.refreshMode.value =
          ZekingRefreshStatus.Refreshing_LoadingView_ing;
      return refreshLoadingWidget;
    }

    /// ======================== 初始化 刷新 空数据 widget ========================

    if (widget.controller.refreshMode.value ==
        ZekingRefreshStatus.Refresh_Empty) {
      if (widget.refreshEmptyWidget == null) {
        refreshEmptyWidget = ZekingRefreshEmptyWidget(
            controller: widget.controller,
            imagePath: widget.refreshEmptyImagePath,
            imageWith: widget.refreshEmptyImageWidth,
            imageHeight: widget.refreshEmptyImageHeight,
            centerPadding: widget.refreshEmptyCenterPadding,
            message: widget.controller._refreshEmptyTip.value ??
                widget.refreshEmptyMessage);
      } else {
        refreshEmptyWidget = ZekingRefreshEmptyWidget(
          controller: widget.controller,
          child: widget.refreshEmptyWidget,
        );
      }

      return refreshEmptyWidget;
    }

    /// ======================== 初始化 刷新 失败 widget ========================

    if (widget.controller.refreshMode.value ==
        ZekingRefreshStatus.Refresh_Faild) {
      if (widget.refreshFailWidget == null) {
        refreshFailWidget = ZekingRefreshFailWidget(
            controller: widget.controller,
            imagePath: widget.refreshFailImagePath,
            imageWith: widget.refreshFailImageWidth,
            imageHeight: widget.refreshFailImageHeight,
            centerPadding: widget.refreshFailCenterPadding,
            message: widget.controller._refreshFaildTip.value ??
                widget.refreshFailMessage);
      } else {
        refreshFailWidget = ZekingRefreshFailWidget(
            controller: widget.controller, child: widget.refreshFailWidget);
      }
      return refreshFailWidget;
    }

    /// ======================== 初始化 业务 loading widget ========================

    // 初始化 加载中 widget
    //（场景：一般用户，事件的操作，比如 登录，上传数据，提交等操作场景）
    if (widget.loadingWidget == null) {
      loadingWidget = ZekingLoadingWidget();
    } else {
      loadingWidget = widget.loadingWidget;
    }

    /// ================================================================================================

    Widget rootChild;

    // 如果支持加载更多，最后就转为CustomScrollview
    if (widget.canLoadMore) {
      List<Widget> slivers;

      if (widget.child is ScrollView) {
        slivers = List.from((widget.child as ScrollView).buildSlivers(context),
            growable: true);
      } else {
        slivers = new List<Widget>();
        slivers.add(SliverList(
            delegate: SliverChildListDelegate(<Widget>[widget.child])));
      }

      // FootWidget
      Widget footWidget;

      if (widget.controller.refreshMode.value ==
          ZekingRefreshStatus.LoadMore_Faild) {
        // =========  加载更多 失败 widget =========
        if (widget.loadFailWidget == null) {
          footWidget = ZekingLoadFailWidget(
              controller: widget.controller,
              message: widget.controller._loadMoreFaildTip.value ??
                  widget.loadFailMessage);
        } else {
          footWidget = ZekingLoadFailWidget(
              controller: widget.controller, child: widget.loadFailWidget);
        }
      } else if (widget.controller.refreshMode.value ==
          ZekingRefreshStatus.LoadMore_NoMore) {
        // =========  加载更多 已加载全部数据 widget =========
        if (widget.loadFailWidget == null) {
          footWidget = ZekingLoadNoMoreWidget(
              message: widget.controller._loadMoreNoMoreTip.value ??
                  widget.loadNoMoreMessage);
        } else {
          footWidget = ZekingLoadNoMoreWidget(child: widget.loadNoMoreWidget);
        }
      } else {
        // =========  加载更多 loading widget =========
        if (widget.loadLoadingWidget == null) {
          footWidget =
              ZekingLoadLoadingWidget(message: widget.loadLoadingMessage);
        } else {
          footWidget = ZekingLoadLoadingWidget(
            child: widget.loadLoadingWidget,
          );
        }
      }

//      slivers.add(footWidget);
      slivers.add(SliverToBoxAdapter(
        child: footWidget,
      ));

      if (widget.canRefresh) {
        if (widget.useScrollController) {
          rootChild = ZekingRefreshIndicator(
            controller: widget.controller,
            displacement:
                widget.displacement == null ? 40.0 : widget.displacement,
            onRefresh: widget.onRefresh,
            child: CustomScrollView(
              controller: _scrollController,
              physics: widget.physics ??
                  ZekingRefreshScrollPhysics(enableOverScroll: false),
              slivers: List.from(slivers, growable: true),
            ),
          );
        } else {
          rootChild = ZekingRefreshIndicator(
            controller: widget.controller,
            displacement:
                widget.displacement == null ? 40.0 : widget.displacement,
            onRefresh: widget.onRefresh,
            child: NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    if (notification.metrics.axis == Axis.vertical) {
                      if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent) {
                        tryLoadMore();
                        return false;
                      }
                    }
                  }
                  return false;
                },
                child: CustomScrollView(
                  physics: widget.physics ??
                      ZekingRefreshScrollPhysics(enableOverScroll: false),
                  slivers: List.from(slivers, growable: true),
                )),
          );
        }
      } else {
        if (widget.useScrollController) {
          rootChild = CustomScrollView(
            controller: _scrollController,
            physics: widget.physics ??
                ZekingRefreshScrollPhysics(enableOverScroll: false),
            slivers: List.from(slivers, growable: true),
          );
        } else {
          rootChild = NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                if (notification.metrics.axis == Axis.vertical) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                    tryLoadMore();
                    return false;
                  }
                }
              }
              return false;
            },
            child: CustomScrollView(
              physics: widget.physics ??
                  ZekingRefreshScrollPhysics(enableOverScroll: false),
              slivers: List.from(slivers, growable: true),
            ),
          );
        }
      }
    } else {
      if (widget.canRefresh) {
        if (widget.child is ScrollView) {
          List<Widget> slivers;

          slivers = List.from(
              (widget.child as ScrollView).buildSlivers(context),
              growable: true);

          rootChild = ZekingRefreshIndicator(
            controller: widget.controller,
            displacement:
                widget.displacement == null ? 40.0 : widget.displacement,
            onRefresh: widget.onRefresh,
            child: CustomScrollView(
              controller: widget.useScrollController ? _scrollController : null,
              physics: widget.physics ??
                  ZekingRefreshScrollPhysics(enableOverScroll: false),
              slivers: List.from(slivers, growable: true),
            ),
          );
        } else {
          rootChild = ZekingRefreshIndicator(
            controller: widget.controller,
            displacement:
                widget.displacement == null ? 40.0 : widget.displacement,
            onRefresh: widget.onRefresh,
            child: widget.child,
          );
        }
      } else {
        rootChild = widget.child;
      }
    }

    return Stack(
      children: <Widget>[
        rootChild,
        Offstage(
          offstage: widget.controller.loadingMode.value !=
              ZekingLoadingStatus.Loading,
          child: loadingWidget,
        )
      ],
    );

    /// ================================================================================================
  }

  @override
  void dispose() {
    if(_scrollController!=null){
      _scrollController.dispose();
    }

    widget.controller.refreshMode.removeListener(_handleRefreshValueChanged);
    super.dispose();
  }

  void tryLoadMore() {
    if (widget.controller.refreshMode.value !=
            ZekingRefreshStatus.Refreshing_LoadingView &&
        widget.controller.refreshMode.value !=
            ZekingRefreshStatus.Refreshing_LoadingView_ing &&
        widget.controller.refreshMode.value != ZekingRefreshStatus.Refreshing &&
        widget.controller.refreshMode.value !=
            ZekingRefreshStatus.LoadMore_Faild &&
        widget.controller.refreshMode.value !=
            ZekingRefreshStatus.LoadMore_NoMore &&
        widget.controller.refreshMode.value !=
            ZekingRefreshStatus.LoadMoreing_ing) {
      widget.controller.refreshMode.value = ZekingRefreshStatus.LoadMoreing_ing;
      widget.onLoading();
    }
  }
}

class ZekingRefreshController {
  ValueNotifier<ZekingRefreshStatus> refreshMode =
      new ValueNotifier(ZekingRefreshStatus.IDLE);

  ValueNotifier<ZekingLoadingStatus> loadingMode =
      new ValueNotifier(ZekingLoadingStatus.IDLE);

  ValueNotifier<String> _refreshFaildTip = new ValueNotifier(null);
  ValueNotifier<String> _refreshEmptyTip = new ValueNotifier(null);
  ValueNotifier<String> _refreshEndWithToastMessage = new ValueNotifier(null);

  ValueNotifier<String> _loadMoreFaildTip = new ValueNotifier(null);
  ValueNotifier<String> _loadMoreNoMoreTip = new ValueNotifier(null);
  ValueNotifier<String> _loadMoreEndWithToastMessage = new ValueNotifier(null);

  ValueNotifier<String> _loadingEndWithToastMessage = new ValueNotifier(null);

  /// 下拉刷新， 成功
  void refreshSuccess({String toastMsg}) {
    _refreshEndWithToastMessage?.value = toastMsg;
    refreshMode?.value = ZekingRefreshStatus.Refresh_Success;
  }

  /// 下拉刷新， 失败
  void refreshFaild({String uiMsg, String toastMsg}) {
    _refreshEndWithToastMessage?.value = toastMsg;
    _refreshFaildTip?.value = uiMsg;
    refreshMode?.value = ZekingRefreshStatus.Refresh_Faild;
  }

  /// 下拉刷新，空数据
  void refreshEmpty({String uiMsg, String toastMsg}) {
    _refreshEndWithToastMessage?.value = toastMsg;
    _refreshEmptyTip?.value = uiMsg;
    refreshMode?.value = ZekingRefreshStatus.Refresh_Empty;
  }

  void refreshingWithLoadingView() {
    refreshMode?.value = ZekingRefreshStatus.Refreshing_LoadingView;
  }

  // ==============================================

  /// 请求 加载更多
  void requestLoading() {
    if (refreshMode?.value == ZekingRefreshStatus.LoadMore_Faild) {
      refreshMode?.value = ZekingRefreshStatus.LoadMoreing;
    }
  }

  /// 加载更多 成功
  void loadMoreSuccess({String toastMsg}) {
    _loadMoreEndWithToastMessage?.value = toastMsg;
    refreshMode?.value = ZekingRefreshStatus.LoadMore_Success;
//    print('loadSuccess');
  }

  /// 加载更多 失败
  void loadMoreFailed({String uiMsg, String toastMsg}) {
    _loadMoreEndWithToastMessage?.value = toastMsg;
    _loadMoreFaildTip?.value = uiMsg;
    refreshMode?.value = ZekingRefreshStatus.LoadMore_Faild;
//    print('loadFailed');
  }

  /// 加载更多 没有更多内容了
  void loadMoreNoMore({String uiMsg, String toastMsg}) {
    _loadMoreEndWithToastMessage?.value = toastMsg;
    _loadMoreNoMoreTip?.value = uiMsg;
    refreshMode?.value = ZekingRefreshStatus.LoadMore_NoMore;
//    print('loadNoMore');
  }

  // ==============================================

  /// 业务处理 加载中
  void loading() {
    loadingMode?.value = ZekingLoadingStatus.Loading;
  }

  void loadingEnd({String toastMsg}) {
    _loadingEndWithToastMessage?.value = toastMsg;
    loadingMode?.value = ZekingLoadingStatus.LoadingEnd;
  }

  void dispose() {
    refreshMode.dispose();
    loadingMode.dispose();
    refreshMode = null;
  }
}
