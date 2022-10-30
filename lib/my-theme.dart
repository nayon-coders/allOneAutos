import 'dart:ui';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class appCollors{
  static const Color mainColors = Color(0xFF2360E8);
  static const Color secColor = Color(0xFFFF7B31);
  static const Color black = Color(0xFF000000);
  static const Color black54 = Colors.black54;
  static const Color grey = Color(0xFF999999);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white200 = Color(0xFFf1f1f1);
  static const Color textColor = Color(0xe0e2c);
}

class ShowAppPopUp{
  static Future<void> success({
  required BuildContext context,
    required String text,
    required VoidCallback onClick,
}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Lottie.asset('assets/images/success.json',
                  width: 50,
                  height: 50,
                  reverse: false,
                  repeat: false,
                ),

                Center(child: Text('$text')),

                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: appCollors.mainColors.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Text("OK",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: appCollors.mainColors,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                )

              ],
            ),
          ),

        );
      },
    );
  }

}