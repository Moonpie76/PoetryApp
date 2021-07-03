
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';
import 'package:poetryapp/models/ju_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  CheckIfAddedService {
  static Future check(JuItem juItem) async {

    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('my_cards');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var openid = prefs.getString('uid');

    dynamic res = await collection.where({
      'id' : juItem.id,
      '_openid': openid
    }).count();
    return res.total;
  }

}