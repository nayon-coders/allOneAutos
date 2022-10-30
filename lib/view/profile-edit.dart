import 'package:car/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../widgets/app-button.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _signUpKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _email = TextEditingController();
  late bool _passwordVisible;

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];


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
        title: Text("Profile Edit", style: TextStyle(fontSize: 12.sp, color: appCollors.black54 ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
           child: Form(
                key: _signUpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
                        _showBottomNavigation(type: '');
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
                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: _focusNodes[0].hasFocus ? Colors.grey.shade200 : Colors.transparent,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0,3),
                          )
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            focusNode: _focusNodes[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appCollors.mainColors
                            ),
                            //  obscureText: !_passwordVisible,
                            controller: _name,
                            decoration: InputDecoration(
                                label: Text("Name"),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.grey
                                ),
                                hintText: "Full name",
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: _focusNodes[0].hasFocus ? Colors.green : Colors.grey,
                                ),
                                prefixIconColor: appCollors.mainColors,
                                contentPadding: EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty ){
                                return "Name must not be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: _focusNodes[1].hasFocus ? Colors.grey.shade200 : Colors.transparent,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0,3),
                          )
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            focusNode: _focusNodes[1],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appCollors.mainColors
                            ),
                            //  obscureText: !_passwordVisible,
                            controller: _email,
                            decoration: InputDecoration(
                                label: Text("Email"),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.grey
                                ),
                                hintText: "johon@gmail.com",
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: _focusNodes[1].hasFocus ? Colors.green : Colors.grey,
                                ),
                                prefixIconColor: appCollors.mainColors,
                                contentPadding: EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty ){
                                return "Email must not be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: _focusNodes[2].hasFocus ? Colors.grey.shade200 : Colors.transparent,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0,3),
                          )
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            focusNode: _focusNodes[2],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appCollors.mainColors
                            ),
                            //  obscureText: !_passwordVisible,
                            controller: _number,
                            decoration: InputDecoration(
                                label: Text("PHONE NUMBER"),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.grey
                                ),
                                hintText: "+1 ***** **** **",
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: _focusNodes[2].hasFocus ? Colors.green : Colors.grey,
                                ),
                                prefixIconColor: appCollors.mainColors,
                                contentPadding: EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty ){
                                return "Phone number must not be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 50,),
                    Bounce(
                      duration: Duration(milliseconds: 80),
                      onPressed: ()=> ChangeProfileInfo(),
                      child: AppButton(text: "Change"),
                    ),

                    SizedBox(height: 10,),
                  ],
                ))
        ),
      ),
    );
  }

  //================== business licence =========================//
  _showBottomNavigation({required String type})async{
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.camera_alt),
                title: const Text('From Camera'),
                onTap: () {
                  //Navigator.pop(context);
                  // setState(() {
                  //   if(type == "business_licence") {
                  //     businessLicencePicker(ImageSource.camera);
                  //   }
                  //   if(type == "state_licence"){
                  //     businessStateLicencePicker(ImageSource.camera);
                  //   }
                  // });


                },
              ),
              ListTile(
                leading: new Icon(Icons.photo),
                title: const Text('From Gallery'),
                onTap: () {

                },
              ),
            ],
          );
        });

  }


  void ChangeProfileInfo(){}
}
