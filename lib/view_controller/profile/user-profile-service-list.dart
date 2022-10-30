import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';
class ProfileServiceUserList extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onClick; 
  const ProfileServiceUserList({
    Key? key, required this.title, this.leading, this.trailing, required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 60),
      onPressed: onClick,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(0,2),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: ListTile(
                leading: leading,
                title: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp
                  ),
                ),
                trailing: trailing
            ),
          )

      ),
    );
  }
}
