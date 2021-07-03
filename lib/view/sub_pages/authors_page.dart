import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:poetryapp/models/poet_model.dart';
import 'package:poetryapp/services/poet_sevice.dart';
import 'package:poetryapp/view/components/poet_card.dart';

class AuthorsPage extends StatefulWidget {
  @override
  _AuthorsPageState createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _easyRefreshController;
  List<PoetItem> _poetList = PoetList([]).list;
  int page = 0;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: '加载中...');
    _easyRefreshController = EasyRefreshController();
    _getPoets().then((value) => {
      EasyLoading.showSuccess('加载成功!')
    });
  }

  Future _getPoets({bool push = false}) async {
    try {
      //调用数据层获取数据
      DbQueryResponse res = await PoetService.getPoets(page: page, limit: 8);

      //将获取后的数据传给模型层，将数据转为实体类
      PoetList poetListModel = PoetList.fromJson(res.data);

      setState(() {
        if (push) {
          _poetList.addAll(poetListModel.list); //数据拼接
        } else {
          _poetList = poetListModel.list; //直接赋值
        }
      });
    } catch (e) {
      error = true;
      errorMsg = e.toString();
      print(errorMsg);
    }
  }

  //下拉刷新
//  Future _onRefresh() async{
//    this.page = 0;
//    await _getPoets(push: false);
//    _easyRefreshController.finishRefresh();
//  }

  //上拉加载
  Future _onLoad() async{
    this.page = _poetList.length;
    await _getPoets(push: true);
    _easyRefreshController.finishLoad();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
        controller: _easyRefreshController,
//        onRefresh: _onRefresh,
        onLoad: _onLoad,
//        header: ClassicalHeader(
//          infoText: '',
//          refreshedText: '刷新完成',
//          refreshText: '刷新中...',
//          refreshReadyText: '刷新完毕',
//          textColor: Color(0xFF999999),
//        ),
        footer: ClassicalFooter(
          infoText: '',
          loadingText: '加载中...',
          textColor: Color(0xFF999999)
        ),
        child: ListView.separated(
          itemCount: _poetList.length,
          itemBuilder: (BuildContext context, int index) {
            return PoetCard(data: _poetList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: .5,
              indent: 75,
              color: Color(0xFFDDDDDD),
            );
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
