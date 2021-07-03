import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';
import 'package:poetryapp/models/ju_model.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  MyPoetrysService {

  static Future add(PoetryItem poetryItem) async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('my_poetry');
    await collection.add({
      'Id' :poetryItem.Id,
      'content':poetryItem.content,
      'shangxi':poetryItem.shangxi,
      'name':poetryItem.name,
      'fanyi':poetryItem.fanyi,
      'about':poetryItem.about,
      'poet':poetryItem.poet,
      'dynasty':poetryItem.dynasty,
    });
  }

  static Future get({int page = 0, int limit = 12}) async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('my_poetry');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var openid = prefs.getString('uid');

    dynamic res = await collection.where({
      '_openid': openid
    }).skip(page).limit(limit).get();
    return res;
  }

  static Future remove(PoetryItem poetryItem) async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('my_poetry');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var openid = prefs.getString('uid');

    await collection.where({
      '_openid': openid,
      'Id': poetryItem.Id
    }).remove();
  }

  static Future check(PoetryItem poetryItem) async {

    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('my_poetry');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var openid = prefs.getString('uid');

    dynamic res = await collection.where({
      'Id' : poetryItem.Id,
      '_openid': openid
    }).count();
    return res.total;
  }

}