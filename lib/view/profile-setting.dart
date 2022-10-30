import 'package:car/main.dart';
import 'package:car/my-theme.dart';
import 'package:car/view/profile-edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../view_controller/profile/user-profile-service-list.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:  appCollors.black54,),
          onPressed: ()=>Navigator.pop(context),
        ),
        title: Text("Profile setting", style: TextStyle(fontSize: 12.sp, color: appCollors.black54 ),),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //================= user profile info =============//
            Container(
              height: 170,
              width: size.width,
              margin:  EdgeInsets.only(left: 20, right: 20,  bottom: 20, top: 10),
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
                  SizedBox(width: 20,),
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


            ),
            //================= user profile info =============//
            const SizedBox(height: 10,),
            ProfileServiceUserList(
              onClick: ()=>Get.to(ProfileEdit(), transition: Transition.rightToLeft),
              leading: Icon(Icons.info_outline, color: Colors.blueGrey,),
              title: "Change Profile Info",
            ),
            SizedBox(height: 10,),
            ProfileServiceUserList(
              onClick: () {  },
              leading: Icon(Icons.password, color: Colors.blueGrey,),
              title: "Change Password",
            ),
            SizedBox(height: 20,),
            Divider(height: 2, color: Colors.grey.shade400,),
            SizedBox(height: 20,),
            ProfileServiceUserList(
              onClick: () {  },
              leading: Icon(Icons.logout_outlined, color: Colors.blueGrey,),
              title: "Logout",
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
