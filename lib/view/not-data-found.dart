import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class NoDataFount extends StatefulWidget {
  const NoDataFount({Key? key}) : super(key: key);

  @override
  State<NoDataFount> createState() => _NoDataFountState();
}

class _NoDataFountState extends State<NoDataFount> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset("assets/images/no-data.json",
            repeat: true,
            reverse: true,
            width: size.width,
            height: 200
        ),
        Text("No data found.",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 10.sp,

          ),
        )
      ],
    );
  }
}
