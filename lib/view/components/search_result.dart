import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/services/search_service.dart';
import 'package:poetryapp/view/components/poetry_card.dart';

class SearchResult extends StatefulWidget {

  late String query;

  SearchResult({Key? key, required String query}) : super(key: key) {
    this.query = query;
  }

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  List<PoetryItem> _poetryList = PoetryList([]).list;
  late EasyRefreshController _easyRefreshController;
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

  Future _getPoetry ({bool push = false}) async {
    try {
      //调用数据层获取数据
      DbQueryResponse res = await SearchService(widget.query).getPoetry(page: this.page);

      //将获取后的数据传给模型层，将数据转为实体类
      PoetryList poetryListModel = PoetryList.fromJson(res.data);

      setState(() {
        if(push) {
          _poetryList.addAll(poetryListModel.list);
        } else {
          _poetryList = poetryListModel.list;
        }
      });

    } catch(e) {
      errorMsg = e.toString();
      error = true;
      print(errorMsg);
    }
  }
  //上拉加载
  Future _onLoad() async{
    this.page = _poetryList.length;
    await _getPoetry(push: true);
    _easyRefreshController.finishLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: EasyRefresh(
          controller: _easyRefreshController,
          onLoad: _onLoad,
          footer: ClassicalFooter(
              infoText: '',
              loadingText: '加载中...',
              textColor: Color(0xFF999999)
          ),
          child: ListView.separated(
            itemCount: _poetryList.length,
            itemBuilder: (BuildContext context, int index) {
              return PoetryCard(data: _poetryList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: .5,
                indent: 15,
                color: Color(0xFFDDDDDD),
              );
            },
          )),
    );
  }

}
