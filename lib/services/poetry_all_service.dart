import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';

import '../connet_cloudbase.dart';

class PoetryAllService {
  static Future getPoetry({int page = 0, int limit = 12}) async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('poetry_info');
    dynamic res = await collection.skip(page).limit(limit).get();
    return res;
  }
}