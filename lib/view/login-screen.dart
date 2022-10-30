import 'dart:convert';

import 'package:car/app-config.dart';
import 'package:car/my-theme.dart';
import 'package:car/view/home-screen.dart';
import 'package:car/view/sign-up-screen.dart';
import 'package:car/widgets/app-button.dart';
import 'package:car/widgets/toster.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:car/widgets/loading-full-screen.dart';
import 'package:car/widgets/small-sub-text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../contorller/auth-controller.dart';
import '../widgets/big-title.dart';
import 'forget-password.dart';

class LoginScreen extends StatefulWidget {
    final int? isSignup;
  const LoginScreen({Key? key, this.isSignup = 0}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthController controller = Get.put(AuthController());

  final _loginFromKey = GlobalKey<FormState>();
  late bool _passwordVisible;


  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    controller.deviceToken = token.toString();
    print("Token Value ${controller.deviceToken}");
  }
  @override
  void initState() {
    // TODO: implement initState
    getDeviceTokenToSendNotification();
    _passwordVisible = false;
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return SafeArea(
        child: Stack(
          children: [
            Scaffold(
              body: Stack(
                children: [
                  widget.isSignup == 1? Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    decoration: BoxDecoration(
                      color: appCollors.mainColors,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your are Recently Registered. Please Login. Thank You. ",
                          style: TextStyle(fontSize: 9.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  ):Center(),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [

                          Lottie.asset("assets/lottie/hi.json", width: 200, height: 150),
                          const BigTitle(title: "Welcome Back"),
                          const SmallSubText(title: "Sign in to Continue"),
                          const SizedBox(height: 30,),
                          Form(
                              key: _loginFromKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [

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
                                          controller: controller.isPhone.value ? controller.number : controller.email,
                                          decoration: InputDecoration(
                                              label: controller.isPhone.value ? Text("Phone Number") : Text("Email"),
                                              labelStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10.sp,
                                                  color: Colors.grey
                                              ),
                                              hintText: controller.isPhone.value ? "000000000000 ": "johon@gmail.com",
                                              prefixIcon: Icon(
                                                controller.isPhone.value ? Icons.call :  Icons.email_outlined,
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: ()=>setState((){
                                        controller.isPhone.value = !controller.isPhone.value;
                                      }),
                                      child:  controller.isPhone.value ? Text("Use Email Address",
                                        style: TextStyle(
                                            color: appCollors.mainColors
                                        ),
                                      ):Text("Use Phone Number",
                                        style: TextStyle(
                                            color: appCollors.mainColors
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
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
                                          controller: controller.pass,
                                          decoration: InputDecoration(
                                            label: const Text("PASSWORD"),
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.sp,
                                                color: Colors.grey
                                            ),
                                            hintText: "******",
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                              color: _focusNodes[1].hasFocus ? Colors.green : Colors.grey,
                                            ),
                                            prefixIconColor: appCollors.mainColors,
                                            contentPadding: EdgeInsets.only(left: 20, right: 20),
                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                            hintStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                  _passwordVisible ?  Icons.visibility_outlined : Icons.visibility_off_outlined,
                                                  color: appCollors.black
                                              ), onPressed: () {
                                              setState(() {
                                                _passwordVisible = !_passwordVisible;
                                              });
                                            },
                                            ),
                                          ),
                                          validator: (value){
                                            if(value!.isEmpty ){
                                              return "Password must not be empty";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: (){
                                        Get.to(ForgetPassword(), transition: Transition.rightToLeft);
                                      },
                                      child: Text(
                                          "Forget Paassword?", style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "ThemeFont",
                                          color: appCollors.mainColors
                                      )
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Bounce(
                                    duration: Duration(milliseconds: 80),
                                    onPressed: (){
                                      if(_loginFromKey.currentState!.validate()){
                                        controller.login();
                                      }

                                    },
                                    child: const AppButton(text: "Login"),
                                  ),

                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: const Text(
                                            "Don't have an account?", style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: "ThemeFont"
                                        )
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      TextButton(
                                        onPressed: ()=> Get.to(SignUpScreen(), transition: Transition.rightToLeft),
                                        child: Text('Sign up', style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "ThemeFont",
                                            color: appCollors.mainColors
                                        )),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),




                                ],
                              ))

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controller.isLoading.value ? const LoadingFullScreen() : const Center(),


          ],
        ),
      );
    }
    );
  }


}
