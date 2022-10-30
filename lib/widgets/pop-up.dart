import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
class AppPopUp{
  static void appDialog({required String icon, required String msg, String? title}){
    Get.defaultDialog(
        title: "$title",
        contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        content: Column(
          children: [
            Lottie.asset("$icon",
              reverse: false,
              repeat:  false,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 15,),
            Text("$msg",
              textAlign: TextAlign.center,
            ),
          ],
        )
    );
  }
}