import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';

class  BookCollectionService {
  /// 列表请求
  static Future getBookCollections() async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('book_collections');
    dynamic res = await collection.get();
    return res;
  }

}