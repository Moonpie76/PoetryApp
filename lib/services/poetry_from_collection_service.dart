import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:poetryapp/models/poetry_model.dart';

import '../connet_cloudbase.dart';

class PoetryFromCollectionService {
  late String collectionName;

  PoetryFromCollectionService(String name) {
    collectionName = name;
  }

  Future getPoetry({int page = 0}) async {
    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);

    dynamic res;

    switch(collectionName){
      case('shijing'):
        res =
        await db.collection('poetry_info').skip(page).limit(12).where({
          "tags": "诗经"
        }).get();
        break;
      case('chuci'):
        res =
        await db.collection('poetry_info').skip(page).limit(12).where({
          "tags": "楚辞"
        }).get();
        break;
      case('tangshi') :
        res =
        await db.collection('poetry_info').skip(page).limit(12).where({
          "tags": "唐诗三百首"
        }).get();
        break;
      case('songci') :
        res =
        await db.collection('poetry_info').skip(page).limit(12).where({
          "tags": "宋词精选"
        }).get();
        break;
      case('shijiushou') :
        res =
        await db.collection('poetry_info').skip(page).limit(12).where({
          "tags": "古诗十九首"
        }).get();
        break;
    }

    return res;

  }

}