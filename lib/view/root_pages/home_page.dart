import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:poetryapp/models/ju_model.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/services/add_to_my_cards_service.dart';
import 'package:poetryapp/services/check_if_added_service.dart';
import 'package:poetryapp/services/ju_service.dart';
import 'package:poetryapp/services/poetry_form_idlist_service.dart';
import 'package:poetryapp/services/remove_from_my_cards_service.dart';
import 'package:poetryapp/view/components/ju_card_banner.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late double index;
  bool isAdded = false;
  late Widget centerPage;

  List<PoetryItem> _poetryList = PoetryList([]).list;
  List<JuItem> _juList = JuList([]).list;
  bool error = false;
  String errorMsg = '';

  _set() {
    if (_juList.length != 0) {
      EasyLoading.showSuccess('加载成功!');
      centerPage = JuCardBanner(
        juList: _juList,
        poetryList: _poetryList,
        changePageCallBack: (page) async {
          setState(() {
            index = page;
          });
          await _check();
        },
      );
      index = _juList.length - 1.0;
      _check();
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: '加载中...');
    centerPage = Container();

    _getData().then((value) => {_set()});
  }

  _getDate() {
    initializeDateFormatting();
    String month = DateFormat('MMM', "zh_CN").format(DateTime.now());
    String day = DateFormat('d', "zh_CN").format(DateTime.now());
    String weekday = DateFormat('EEEE', "zh_CN").format(DateTime.now());
    String date = "$month$day  $weekday";
    return date;
  }

  Future _getData() async {
    try {
      DbQueryResponse res = await JuService.getJu();
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

  _check() async {
    int res = await CheckIfAddedService.check(_juList[index.round()]);
    if (res == 0) {
      setState(() {
        isAdded = false;
      });
    } else {
      setState(() {
        isAdded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text(
          _getDate(),
          style: TextStyle(
            color: Color(0xFF415E89),
            fontSize: 16,
            fontFamily: 'FangZhengShuSongJianTi'
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                isAdded ? Icons.star : Icons.star_border,
                color: Color(0xFF415E89),
              ),
              onPressed: () {
                if (!isAdded) {
                  AddToMyCardsService.add(_juList[index.round()]);
                  setState(() {
                    isAdded = true;
                  });
                } else {
                  RemoveFromMyCardsService.remove(_juList[index.round()]);
                  setState(() {
                    isAdded = false;
                  });
                }
              })
        ],
      ),
      body: Container(alignment: Alignment.center, child: centerPage),
      backgroundColor: Color(0xFFf2f2f2),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
