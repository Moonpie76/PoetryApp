import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/services/my_poetry_service.dart';
import 'package:poetryapp/view/components/detail_bottom.dart';
import 'package:poetryapp/view/components/detail_tab.dart';

class PoetryDetailPage extends StatefulWidget {
  late PoetryItem data;
  late String zhushi;
  late String yiwen;
  late String jianshang;
  List<Widget> content = <Widget>[];
  PoetryDetailPage({Key? key, required PoetryItem data}) : super(key: key) {
    this.data = data;
    zhushi =
        data.fanyi.contains("注释") ? data.fanyi.split('注释')[1].trimLeft() : '您查看的诗文暂无注释';
    String temp =
        data.fanyi.contains("注释") ? data.fanyi.split('注释')[0] : data.fanyi;
    yiwen =
        data.fanyi.contains("译文") ? temp.replaceAll('译文', '').trimLeft() : '您查看的诗文暂无译文';

    if (data.shangxi.contains('赏析') ||
        data.shangxi.contains('鉴赏') ||
        data.shangxi.contains('简析')) {
      String temp = data.shangxi.replaceAll('赏析', '');
      temp = temp.replaceAll('鉴赏', '');
      temp = temp.replaceAll('简析', '');
      jianshang = temp.trimLeft();
    } else {
      jianshang = '您查看的诗文暂无赏析';
    }

    List<String> textList = <String>[];
    List<String> lineList = <String>[];
    for (int i = 0; i < data.content.length; i++) {
      var str = data.content[i];
      if (str == ' ') {
        continue;
      }
      if (str == '\n') {
        if (lineList.length != 0) {
          textList.add(_listToString(lineList));
        }
        lineList = [];
        continue;
      }
      if (str == '，' ||
          str == '。' ||
          str == '、' ||
          str == '；' ||
          str == '！' ||
          str == '?' ||
          str == '：' ||
          str == '？') {
        lineList.add(str);
        textList.add(_listToString(lineList));
        lineList = [];
      } else {
        lineList.add(str);
      }
    }

    textList.forEach((line) {
      content.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            line,
            style: TextStyle(fontSize: 18, color: Color(0xFF626567),fontFamily: 'FangZhengShuSongJianTi',),
          ),
          Padding(padding: EdgeInsets.only(top: 30))
        ],
      ));
    });
  }

  String _listToString(List<String> list) {
    String result = '';
    list.forEach((string) =>
        {if (result == '') result = string else result = '$result$string'});
    return result.toString();
  }

  @override
  _PoetryDetailPageState createState() => _PoetryDetailPageState();
}

class _PoetryDetailPageState extends State<PoetryDetailPage> {
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  _check() async {
    int res = await MyPoetrysService.check(widget.data);
    if (res == 0) {
      if (mounted) {
        setState(() {
          isAdded = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isAdded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },

            icon: Icon(Icons.arrow_back_ios),

          ),
          elevation: 1,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  isAdded ? Icons.star : Icons.star_border,
                  color: Color(0xFF415E89),
                ),
                onPressed: () {
                  if (!isAdded) {
                    MyPoetrysService.add(widget.data);
                    setState(() {
                      isAdded = true;
                    });
                  } else {
                    MyPoetrysService.remove(widget.data);
                    setState(() {
                      isAdded = false;
                    });
                  }
                })
          ],
        ),
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top: 50)),
                                  Text(
                                    widget.data.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'FangZhengShuSongJianTi',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 50)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "[${widget.data.dynasty}]",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'FangZhengShuSongJianTi',
                                            color: Color(0xFF415E89)),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text(
                                        widget.data.poet,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'FangZhengShuSongJianTi',
                                            color: Color(0xFF415E89)),
                                      )
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 50)),
                                  Column(
                                    children: widget.content,
                                  )
                                ],
                              ),
                            ),
                          ),
                          DetailBottom(
                            zhushi: widget.zhushi,
                            yiwen: widget.yiwen,
                            jianshang: widget.jianshang,
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
