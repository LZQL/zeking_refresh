import 'package:zeking_refresh_example/common/index_all.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ZekingRefreshController _refreshController;

  int i = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = new ZekingRefreshController();
    _refreshController.refreshEmpty();
  }

  @override
  Widget build(BuildContext context) {
//    BoxScrollView
    return MaterialApp(
        home: HomePage());
  }


}



