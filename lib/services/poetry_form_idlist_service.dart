import 'dart:math';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';

class  PoetryFromIdListService {
  /// 列表请求
  static Future getPoetry(List<int> idList) async {

    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('poetry_info');

    var _ = db.command;

    dynamic res = await collection.where({
      'Id' : _.into(idList)
    }).limit(20).get();
    return res;
  }

}