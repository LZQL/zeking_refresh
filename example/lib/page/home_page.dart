import 'package:zeking_refresh_example/common/index_all.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zeking Refresh Plugin example app'),
      ),
      body: ListView(
        children: <Widget>[
          ItemWidget('1. 默认场景UI展示', () {
            NavigatorUtil.pushPage(context, DefaultScenarioUiPage());
          }),
          ItemWidget('2. 配置默认场景UI展示', () {}),
          ItemWidget('3. 自定义场景UI展示', () {}),
          ItemWidget('4. 默认场景下动态改变 提示语 和 吐司提示', () {}),
          ItemWidget('5. 自定义场景下动态改变 提示语 和 吐司提示', () {}),
        ],
      ),
    );
  }


}
