import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
用法：
ConnectCloudbase.connectToCloudbase();
CloudBaseDatabase db = CloudBaseDatabase(ConnectCloudbase.core);
 */
class ConnectCloudbase {
  static String _envId = 'flutter-cloud-8gqalh79c7c1a544';
  static late CloudBaseCore core;

  static connectToCloudbase () async{
    core = CloudBaseCore.init({
      'env': _envId,
      'envId': _envId,
      'appAccess': {
        'key': 'd33b7e52cb0b40a539cdb9b52a3e875f',
        'version': '1'
      }
    });
    CloudBaseAuth auth = CloudBaseAuth(core);
    CloudBaseAuthState? authState = await auth.getAuthState();

    if(authState == null) {
      await auth.signInAnonymously();
    }

    if(authState != null) {
      var userInfo = await auth.getUserInfo();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid') ?? 'null';
      if(uid == 'null') {
        prefs.setString('uid', userInfo.uuid);
      }
    }

  }
}