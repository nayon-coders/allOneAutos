import 'package:car/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StatusButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onClick;
  final IconData icon;
  const StatusButton({
    Key? key, required this.title, required this.color, required this.onClick, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onClick,
        child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top:7, bottom: 7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
               icon,
                color: Colors.white,
              ),
              SizedBox(width: 5,),
              Text("$title",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: appCollors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
