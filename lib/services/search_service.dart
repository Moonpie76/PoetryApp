import 'package:cloudbase_database/cloudbase_database.dart';

import '../connet_cloudbase.dart';

class SearchService {
  late String query;

  SearchService(String query) {
    this.query = query;
  }

  Future getPoetry({int page = 0}) async {
    await ConnectCloudbase.connectToCloudbase();
    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);

    dynamic res;

    var _ = db.command;

    res = await db.collection('poetry_info').limit(12).skip(page).where(_.or([
      {
        "poet.name": query
      },
      {
        "tags": query
      },
      {
        "name": db.regExp(
          query,
          'i',
        ),
      },
      {
        "content": db.regExp(
          query,
          'i',
        ),
      }

    ])).get();

    return res;

  }
}