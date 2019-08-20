

import 'package:zeking_refresh_example/common/index_all.dart';


class ItemWidget extends StatefulWidget {

  final Function onTap;
  final String title;


  ItemWidget(this.title, this.onTap);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15),
            height: 50,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 16, color: Color(0xff333333)),
            ),
          ),
          Container(
            color: Color(0xFFe5e5e5),
            width: double.infinity,
            height: 0.5,
          )
        ],
      ),
    );
  }
}