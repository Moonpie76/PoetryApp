import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';

import '../connet_cloudbase.dart';

class PoetryFromAuthorService {
  late int authorId;

  PoetryFromAuthorService(int authorId) {
    this.authorId = authorId;
  }

  Future getPoetry({int page = 0}) async {
    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);

    dynamic res;

    res = await db.collection('poetry_info').limit(12).skip(page).where({
      "poet.Id": authorId
    }).get();

    return res;

  }
}