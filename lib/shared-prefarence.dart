import 'package:shared_preferences/shared_preferences.dart';

class AppLocalDatabase{

  static Future<bool> isLoginUser()async{
    var isLogin;
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    isLogin = localDatabase.getString("isLogin");
    print(isLogin);
    if(isLogin == "1"){
      return true;
    }else{
      return false;
    }
  }


}