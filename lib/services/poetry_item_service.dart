import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:poetryapp/connet_cloudbase.dart';

class  PoetryItemService {
  late int poetryId;

  PoetryItemService(this.poetryId);

  Future getPoetryItem() async {

    await ConnectCloudbase.connectToCloudbase();

    CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
    Collection collection = db.collection('poetry_info');
    dynamic res = await collection.where({
      "Id" : poetryId
    }).get();
    return res;
  }

}