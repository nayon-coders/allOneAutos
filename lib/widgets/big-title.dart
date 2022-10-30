import 'package:car/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class BigTitle extends StatelessWidget {
    final String title;
    const BigTitle({
        Key? key, required this.title,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Text("$title",
            style: TextStyle(
                    fontSize: 20.sp,
        color: appCollors.black,
        fontFamily: "nunito",
        fontWeight: FontWeight.w800
        ),
        );
    }
}
