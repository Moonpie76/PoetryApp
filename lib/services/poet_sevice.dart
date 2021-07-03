import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  PoetService {
  /// 列表请求
  static Future getPoets({int page = 0, int limit = 8}) async {

    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);

    Collection collection = db.collection('poet_info');
    dynamic res = await collection.skip(page).limit(limit).get();
    return res;
  }

}