import 'dart:math';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';

class  JuService {
  /// 列表请求
  static Future getJu() async {

    List<int> idList = <int>[];

    //随机生成20个id
    int i = 0;
    while(i < 21) {
      int id = new Random().nextInt(5760);
      if(idList.length == 0) {
        idList.add(id);
        i++;
      } else {
        //不重复
        if(!idList.contains(id)) {
          idList.add(id);
          i++;
        }
      }
    }

    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('ju');

    var _ = db.command;

    dynamic res = await collection.where({
      'id' : _.into(idList)
    }).limit(20).get();
    return res;
  }

}