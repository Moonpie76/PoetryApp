import 'package:flutter/material.dart';

class DetailTab extends StatefulWidget {
  late String tab;

  DetailTab({Key? key, required String data}) : super(key: key) {
    this.tab = data;
  }

  @override
  _DetailTabState createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Text(
                  widget.tab,
                  style: TextStyle(fontSize: 15,fontFamily: 'FangZhengShuSongJianTi', color: Color(0xFF626567)),
                ),
              ],
            ),
          )
        ]))
      ],
    );
  }
}
