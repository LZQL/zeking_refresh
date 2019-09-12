
# ChangeLog

## 0.0.11

    修复0.0.10不完善的bug

## 0.0.10

    修复与NestedScrollView配合的时候，加载更多存在的问题

## 0.0.9

    将 业务逻辑 状态 Loading 和 LoadingEnd  单独抽取出来，防止和loadmore 相关状态之间存在冲突，倒是页面显示异常

## 0.0.8

    修复当canLoadMore为false，canRefresh为true的时候，
    child为CustomScrollview，在IOS上面的滚动bug。

## 0.0.7

    1. onRefresh 属性不再是必填项目，根据canRefresh做判断
    2. 更改最后的控件生成逻辑，只有canLoadMore为true的时候，
       最后控件才会转为CustomScrollview。不然你写的是什么widget
       就是什么widget，不做改变。
    3. 这次修改以后，业务loading widget 得到了更广泛的应用，
       不管你的页面是否需要下拉刷新，上啦加载更多，只要你的页面需要
       使用到业务loading 这样的布局，就可以直接使用zeking_refresh

## 0.0.6

    修复多次调用onLoading方法的bug

## 0.0.5

    更新文档说明,修复和NestedScrollView一起使用的时候的bug

## 0.0.4

    更新文档说明

## 0.0.3

    修复小问题

## 0.0.2

    解决引用之后 项目跑不起来的bug


## 0.0.1

    初始化上传

