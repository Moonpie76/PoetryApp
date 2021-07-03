import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'detail_tab.dart';

class DetailBottom extends StatefulWidget {
  //译文（注释、赏析）的内容
  late String zhushi;
  late String yiwen;
  late String jianshang;

  DetailBottom(
      {Key? key,
      required String zhushi,
      required String yiwen,
      required String jianshang})
      : super(key: key) {
    this.zhushi = zhushi;
    this.yiwen = yiwen;
    this.jianshang = jianshang;
  }

  @override
  _DetailBottomState createState() => _DetailBottomState();
}

class _DetailBottomState extends State<DetailBottom> {
  late String data;
  _onPressed(String data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 52.0,
        child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20)),
                InkWell(
                  child: Text(
                    "注释",
                    style: TextStyle(color: Color(0xFF641E16)),
                  ),
                  onTap: () {
                    _onPressed(widget.zhushi);
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: false,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        builder: (BuildContext context) {
                          return Container(
                            child: DetailTab(
                              data: this.data,
                            ),
                          );
                        });
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                InkWell(
                    onTap: () {
                      _onPressed(widget.yiwen);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          builder: (BuildContext context) {
                            return Container(
                              child: DetailTab(
                                data: this.data,
                              ),
                            );
                          });
                    },
                    child:
                        Text("译文", style: TextStyle(color: Color(0xFF641E16)))),
                Padding(padding: EdgeInsets.only(left: 20)),
                InkWell(
                    onTap: () {
                      _onPressed(widget.jianshang);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          builder: (BuildContext context) {
                            return Container(
                              child: DetailTab(
                                data: this.data,
                              ),
                            );
                          });
                    },
                    child:
                        Text("赏析", style: TextStyle(color: Color(0xFF641E16))))
              ],
            )));
  }
}
