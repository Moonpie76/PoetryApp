import 'package:flutter/material.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:poetryapp/models/ju_model.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/services/get_my_cards_service.dart';
import 'package:poetryapp/services/poetry_form_idlist_service.dart';
import 'package:poetryapp/view/components/ju_card_banner.dart';

class MyCardsPage extends StatefulWidget {
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {

  List<PoetryItem> _poetryList = PoetryList([]).list;
  List<JuItem> _juList = JuList([]).list;
  bool error = false;
  String errorMsg = '';
  late Widget centerPage;

  _set() {
    if(_juList.length == 0) {
      centerPage = Center(
        child: Text("暂无摘录"),
      );
    } else {
      EasyLoading.showSuccess('加载成功!');
      centerPage = Center(
        child: JuCardBanner(
            juList: _juList,
            poetryList: _poetryList,
            changePageCallBack: (page) {}),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: '加载中...');
    centerPage = Container();

    _getData().then((value) => {
     _set()
    });

  }

  Future _getData() async {
    try {
      DbQueryResponse res = await GetMyCardsService.get();

      JuList juListModel = JuList.fromJson(res.data);

      List<int> idList = <int>[];
      for (var ju in juListModel.list) {
        idList.add(ju.poetryId);
      }
      DbQueryResponse result = await PoetryFromIdListService.getPoetry(idList);
      PoetryList poetryListModel = PoetryList.fromJson(result.data);

      if (mounted) {
        setState(() {
          _juList = juListModel.list;
          _poetryList = poetryListModel.list;
        });
      }
    } catch (e) {
      error = true;
      errorMsg = e.toString();
      print(errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return centerPage;
  }
}
