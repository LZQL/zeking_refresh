[TOC]

# zeking_refresh

一个支持刷新加载中，刷新失败，刷新空数据，加载更多加载中，加载更多失败，加载更多加载全部数据，业务loading的刷新组件

## 1. 快速使用

### 1. 依赖

```
dependencies:
  zeking_refresh: ^0.0.4
```

### 2. 安装

```
flutter packages get
```

### 3. 引用

```
import 'package:zeking_refresh/zeking_refresh.dart';
```

### 4. 简单使用

```
  ZekingRefreshController _refreshController;

  @override
  void initState() {
    _refreshController = ZekingRefreshController();
    super.initState();

    /// 首次进去 加载数据 ，会自动调用 onRefresh 方法
    _refreshController.refreshingWithLoadingView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZekingRefresh(
        controller: _refreshController,  // 必须参数
        onRefresh: onRefresh,            // 目前是必须参数，后面版本看看是否修改
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
```

## 2. ZekingRefreshController

通过 `ZekingRefreshController` 的方法来进行不同场景的UI展示


| 方法                                            | 说明                                         |
|------------------------------------------------|-----------------------------------------------------------|
|refreshingWithLoadingView()                     | 刷新：打开一个新的页面，首先有一个圈圈在中间转，同时请求数据 widget |
|refreshFaild({String uiMsg, String toastMsg})   | 刷新：数据为空 widget|
|refreshEmpty({String uiMsg, String toastMsg})   | 刷新：失败 widget|
|refreshSuccess({String toastMsg})               | 刷新：成功，修改状态，显示结果|
|loadMoreFailed({String uiMsg, String toastMsg}) | 加载更多：失败 widget|
|loadMoreNoMore({String uiMsg, String toastMsg}) | 加载更多：已加载全部数据widget|
|loadMoreSuccess({String toastMsg})              | 加载更多：成功，修改状态，|
|loading()                                       | 业务加载中：loading widget （ 业务加载中：比如，上传图片，登录，提交数据的loading widget ）|
|loadingEnd({String toastMsg})                   | 业务加载中： 结束 loading widget 的展示|

> 说明一下：在上面的方法中，有的方法有` uiMsg`  和 `toastMsg `参数，是干什么的呢？

> `uiMsg` 是用来动态修改 场景`Ui `上面的提示语的, 但是这个只对使用了框架默认的`UI` 才会起作用，若是自定义的 `widget`，需要在外部自己去`setState`

> `toastMsg` 是用来谈吐司提示的，默认已经实现了 `toast` ，当然你不满足于默认的吐司样式，
> 可以自己去定义，也可以弹一个`dialog`，或者打印一个`log`，到时候传一个方法给我就好了，
> 具体的看`ZekingRefresh`的`toastMethod`参数，下面


## 3. ZekingRefresh

这个就是我们的刷新控件了，


```
ZekingRefresh({
        @required this.controller,
        @required this.onRefresh,
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
                  this.toastMethod
              });
```


| 参数                                            | 说明                                          |
|------------------------------------------------|-----------------------------------------------------------|
|controller                                      | 其实就是 ZekingRefreshController 用来控制不同场景的切换        |
|onRefresh                                       | 刷新方法|
|onLoading                                       | 加载更多方法|
|child                                           | 其实最后都会转为CustomScrollview，所以写特殊布局的时候需要注意一下|
|displacement                                    | 下拉刷新圈圈的偏移量，默认是40|
|canLoadMore                                     | 是否支持加载更多，默认 true|
|canRefresh                                      | 是否支持 下拉刷新，默认 true|
|useScrollController                             | 是否给默认的ScrollController ，默认 true|
|scrollController                                | 当useScrollController为true，ScrollController也为null的话，会new 一个 useScrollController|
|physics                                         | ScrollPhysics|
|======================|======================|
|refreshLoadingWidget                            | 自定义的  刷新 加载中 widget |
|refreshLoadingImagePath                         | 设置框架 默认 的 刷新 加载中 widget的图片路径，会自动旋转 ，refreshLoadingWidget 和 refreshLoadingImagePath 都不设置的话，默认显示一个CircularProgressIndicator|
|======================                          |======================|
|refreshEmptyWidget                              |  自定义的 刷新 空数据 的 widget |
|refreshEmptyMessage                             |  设置框架 默认 刷新 空数据 widget 的 提示语 |
|refreshEmptyImagePath                           |  设置框架 默认 刷新 空数据 widget 的 图片路径，（图片和提示语的位置是居中，图片在上，提示语在下） |
|refreshEmptyImageWidth                          |  设置框架 默认 刷新 空数据 widget 的 图片 宽度 ，默认 136|
|refreshEmptyImageHeight                         |  设置框架 默认 刷新 空数据 widget 的 图片 高度 ， 默认 122|
|refreshEmptyCenterPadding                       |  设置框架 默认 刷新 空数据 widget 的 图片 和 提示语 的间隔，默认 36|
|======================                          |======================|
|refreshFailWidget                               |  自定义的 刷新 失败 widget |
|refreshFailMessage                              |  设置框架 默认 刷新 失败 widget 的 提示语 |
|refreshFailImagePath                            |  设置框架 默认 刷新 失败 widget 的 图片路径 ，（图片和提示语的位置是居中，图片在上，提示语在下）|
|refreshFailImageWidth                           |  设置框架 默认 刷新 失败 widget 的 图片 宽度 ，默认 136|
|refreshFailImageHeight                          |  设置框架 默认 刷新 失败 widget 的 图片 高度 ， 默认 122|
|refreshFailCenterPadding                        |  设置框架 默认 刷新 失败 widget 的 图片 和 提示语 的间隔，默认 36|
|======================                          |======================|
|loadLoadingWidget                               | 自定义的  加载更多 加载中 widget |
|loadLoadingMessage                              | 设置框架 默认 的 加载更多 加载中 widget的提示语|
|======================                          |======================|
|loadFailWidget                                  | 自定义的  加载更多 失败 widget |
|loadFailMessage                                 | 设置框架 默认 的 加载更多 失败 widget的提示语|
|======================                          |======================|
|loadNoMoreWidget                                | 自定义的  加载更多 已加载全部数据 widget |
|loadNoMoreMessage                               | 设置框架 默认 的 加载更多 已加载全部数据 widget的提示语|
|======================                          |======================|
|loadingWidget                                   | 自定义的  业务加载中  widget （业务加载中：比如，上传图片，登录，提交数据的loading widge）|
|======================                          |======================|
|toastMethod                                     | 自定义的  弹吐司方法，|