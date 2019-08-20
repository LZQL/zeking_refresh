# zeking_refresh

A new Flutter plugin.

## Getting Started

一个支持刷新加载中，刷新失败，刷新空数据，加载更多加载中，加载更多失败，加载更多加载全部数据，业务loading的刷新组件


具体去 github 上面查看 用法

`ZekingRefreshController  `拥有的相关方法
方法 | 说明 |
-|-|-
refreshingWithLoadingView() | 刷新：打开一个新的页面，首先有一个圈圈在中间转，同时请求数据 widget |
refreshFaild({String uiMsg, String toastMsg}) | 刷新：数据为空 widget|
refreshEmpty({String uiMsg, String toastMsg}) | 刷新：失败 widget|
refreshSuccess({String toastMsg})| 刷新：成功，修改状态，显示结果
loadMoreFailed({String uiMsg, String toastMsg})| 加载更多：失败 widget
loadMoreNoMore({String uiMsg, String toastMsg}) | 加载更多：已加载全部数据widget
loadMoreSuccess({String toastMsg}) | 加载更多：成功，修改状态，
loading() | 业务加载中：loading widget
loadingEnd({String toastMsg}) | 业务加载中： 结束 loading widget 的展示