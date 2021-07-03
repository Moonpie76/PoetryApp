import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';
import 'package:poetryapp/models/ju_model.dart';

class  AddToMyCardsService {
  /// 列表请求
  static Future add(JuItem juItem) async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('my_cards');
    await collection.add({
      'poetryId': juItem.poetryId,
      'poetName': juItem.poetName,
      'content': juItem.content,
      'id': juItem.id
    });
  }


}