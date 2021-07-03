import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:poetryapp/models/book_collection_model.dart';
import 'package:poetryapp/services/collection_book_service.dart';
import 'package:poetryapp/view/components/collection_card.dart';

class CollectionsPage extends StatefulWidget {
  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}


class _CollectionsPageState extends State<CollectionsPage> with AutomaticKeepAliveClientMixin{
  List<BookCollectionItem> _bookcollectionList = BookCollectionList([]).list;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: '加载中...');
    _getBookCollections().then((value) => {
       EasyLoading.showSuccess('加载成功!')
    });
  }

  Future _getBookCollections() async{
    try {
      DbQueryResponse res = await BookCollectionService.getBookCollections();
      BookCollectionList _bookCollectionListModel = BookCollectionList.fromJson(res.data);

      setState(() {
        _bookcollectionList = _bookCollectionListModel.list;
      });
    } catch(e) {
      errorMsg = e.toString();
      error = true;
      print(errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Color(0xFFEFEFEF),
      padding: EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _bookcollectionList.length,
        itemBuilder: (context, index) {
          return CollectionCard(data: _bookcollectionList[index]);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
