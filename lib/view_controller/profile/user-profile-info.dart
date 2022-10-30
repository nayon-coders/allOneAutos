import 'package:car/my-theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileInfoUser extends StatelessWidget {
  const ProfileInfoUser({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: size.width,
      color: appCollors.mainColors.withOpacity(0.2),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          InkWell(
            onTap:(){
              print("Dasfds");
              //ActionInProfile().uploadProfile();
            },
            child: Container(
              width: 120,
              height: 120,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3, color: appCollors.mainColors)
              ),
              child: Column(
                children: [
                  Image.asset("assets/images/upload.png", height: 70, width: 70,),
                  Text("Upload Profile",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 8.sp
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 30,),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("NAYON TALUKDER",
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("nayon.coders@gmail.com",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(width: 5,),
                    Icon(Icons.check_circle, color: appCollors.mainColors, size: 20,)
                  ],
                ),
                Text("+8801814569747",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
          )
        ],
      ),


    );
  }
}
