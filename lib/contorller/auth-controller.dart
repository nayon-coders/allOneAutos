import 'dart:convert';

import 'package:car/app-config.dart';
import 'package:car/view/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/toster.dart';


class AuthController extends GetxController{
   final name = TextEditingController();
   final email = TextEditingController();
   final number = TextEditingController();
   final pass = TextEditingController();
   final Cpass = TextEditingController();
  late final String? deviceToken;

  var isLoading = false.obs;
  var isPhone = false.obs;

  void isLogin(value){
    isLoading.value = value;
    update();
  }

  Future login()async{
    isLogin(true);
    //local database
    SharedPreferences localDatabase = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppConfig.login),
      body: {
        "email" : name.text,
        "password" : pass.text,
        "phone" : isPhone.value ? number :'',
        "device_token" : deviceToken,
      },
    );


    var data = jsonDecode(response.body);
    // print(data["data"]["user"]['id']);

    if(response.statusCode == 200){
      isLogin(false);
      AppTost().successTost(text: "Login Success");
      localDatabase.setString("token", data["data"]["token"]);
      localDatabase.setString("userID", data["data"]["user"]["id"].toString());
      localDatabase.setString("user_email", data["data"]["user"]["email"].toString());
      localDatabase.setString("user_number", data["data"]["user"]["number"].toString());
      print(localDatabase.getString("userID"));
      localDatabase.setString("isLogin", "1");
      Get.to(HomeScreen(), transition: Transition.rightToLeft);

    }else{
      isLogin(false);
      AppTost().successTost(text: "Email/Password is incorrect");
    }
    isLogin(false);
    print(response.statusCode);
    print(response.body);

  }

}