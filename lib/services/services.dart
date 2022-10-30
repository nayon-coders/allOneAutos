import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../app-config.dart';
class ApiServices{


   Future<http.Response> userData()async{
    String? userId;
    String? token;

    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    userId = localDatabase.getString("userID");
    token = localDatabase.getString("token");
    print(token);
    print(userId);
    return await http.get(Uri.parse(AppConfig.Baseurl+"/profile/${userId}"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }





}