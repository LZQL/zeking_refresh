import 'package:zeking_refresh_example/common/index_all.dart';

import 'example_page_04.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zeking Refresh Plugin example app'),
      ),
      body: ListView(
        children: <Widget>[
          ItemWidget('1. 默认场景UI展示', () {
            NavigatorUtil.pushPage(context, ExamplePage01());
          }),
          ItemWidget('2. 配置默认场景UI展示', () {
            NavigatorUtil.pushPage(context, ExamplePage02());
          }),
          ItemWidget('3. 自定义场景UI展示', () {
            NavigatorUtil.pushPage(context, ExamplePage03());
          }),
          ItemWidget('4. 设置 全局 场景UI展示', () {
            NavigatorUtil.pushPage(context, ExamplePage04());
          }),
          ItemWidget('5. 默认场景下动态改变 提示语 和 吐司提示', () {
            NavigatorUtil.pushPage(context, ExamplePage05());
          }),
          ItemWidget('6. 自定义场景下动态改变 提示语 和 吐司提示', () {
            NavigatorUtil.pushPage(context, ExamplePage06());
          }),
          ItemWidget('7. 自定义 吐司 样式 为 弹框提示', () {
            NavigatorUtil.pushPage(context, ExamplePage07());
          }),
          ItemWidget('8. 和 CustomScrollView 使用 ', () {
            NavigatorUtil.pushPage(context, ExamplePage08());
          }),
          ItemWidget('9. 和 NestedScrollView 使用 ', () {
            NavigatorUtil.pushPage(context, ExamplePage09());
          }),
        ],
      ),
    );
  }


}
