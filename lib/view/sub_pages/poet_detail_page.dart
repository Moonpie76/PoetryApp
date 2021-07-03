import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:poetryapp/models/poet_model.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/services/poetry_from_author_service.dart';
import 'package:poetryapp/view/components/poetry_card.dart';

class PoetDetailPage extends StatefulWidget {
  late PoetItem data;

  PoetDetailPage({Key? key, required PoetItem data}) : super(key: key) {
    this.data = data;
  }

  @override
  _PoetDetailPageState createState() => _PoetDetailPageState();
}

class _PoetDetailPageState extends State<PoetDetailPage> with AutomaticKeepAliveClientMixin{
  late EasyRefreshController _easyRefreshController;
  List<PoetryItem> _poetryList = PoetryList([]).list;
  int page = 0;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: '加载中...');
    _easyRefreshController = EasyRefreshController();
    _getPoetry().then((value) => {
      EasyLoading.showSuccess('加载成功!')
    });
  }

  Future _getPoetry({bool push = false}) async {
    try {
      //调用数据层获取数据
      DbQueryResponse res = await PoetryFromAuthorService(widget.data.poet_id)
          .getPoetry(page: page);

      //将获取后的数据传给模型层，将数据转为实体类
      PoetryList poetryListModel = PoetryList.fromJson(res.data);

      setState(() {
        if (push) {
          _poetryList.addAll(poetryListModel.list); //数据拼接
        } else {
          _poetryList = poetryListModel.list; //直接赋值
        }
      });
    } catch (e) {
      error = true;
      errorMsg = e.toString();
      print(errorMsg);
    }
  }

  //上拉加载
  Future _onLoad() async {
    this.page = _poetryList.length;
    await _getPoetry(push: true);
    _easyRefreshController.finishLoad();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
      ),
      body: EasyRefresh(
        controller: _easyRefreshController,
        onLoad: _onLoad,
        footer: ClassicalFooter(
            infoText: '',
            loadingText: '加载中...',
            textColor: Color(0xFF999999)
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '诗人简介',
                            style: TextStyle(
                                color: Color(0xFF641E16),
                              fontSize: 18
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(widget.data.desc, style: TextStyle(fontFamily: 'FangZhengShuSongJianTi',fontSize: 15),)
                      ],
                    ),
                  ),

                ])),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '作品',
                            style: TextStyle(
                                color: Color(0xFF641E16),
                                fontSize: 18
                            )
                        ),
                      ],
                    ),
                  ),

                ])),
            SliverList(
              delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    //创建列表项
                    return Column(
                      children: <Widget>[
                        PoetryCard(data: _poetryList[index]),
                        Divider(
                          height: .5,
                          indent: 15,
                          color: Color(0xFFDDDDDD),
                        )
                      ],
                    );
                  },
                  childCount: _poetryList.length //50个列表项

              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
