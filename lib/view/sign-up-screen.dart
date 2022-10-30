import 'dart:convert';
import 'dart:math';

import 'package:car/app-config.dart';
import 'package:car/contorller/auth-controller.dart';
import 'package:car/my-theme.dart';
import 'package:car/view/verify-email.dart';
import 'package:car/view/login-screen.dart';
import 'package:car/widgets/toster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../widgets/app-button.dart';
import '../widgets/big-title.dart';
import '../widgets/loading-full-screen.dart';
import '../widgets/small-sub-text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
  final _signUpKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cPass = TextEditingController();
  late bool _passwordVisible;

  bool _isPassMatch = false;
  bool _isPassValid = false;

  bool _isEmailValid = false;
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {

    // TODO: implement initState
    _passwordVisible = false;
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {
        });
      });
    });
  }

  @override
  dispose() {
    AnimationController.unbounded(vsync: this).dispose();
    super.dispose();
  }
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
              color: appCollors.mainColors,
              icon: Icon(
                Icons.arrow_back
              ),
            ),
          ),
          backgroundColor: Colors.white,

          body:
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: BigTitle(title: "Create account")),
                      Center(child: SmallSubText(title: "Create a new accoun")),
                      SizedBox(height: 30,),
                      Form(
                          key: _signUpKey,
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
                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 8),
                                decoration: BoxDecoration(
                                  border: _isPassValid ? Border.all(width: 2, color: Colors.red) : Border.all(width: 0, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _focusNodes[3].hasFocus ? Colors.grey.shade200 : Colors.transparent,
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
                                      focusNode: _focusNodes[3],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appCollors.mainColors
                                      ),
                                      //  obscureText: !_passwordVisible,
                                      controller: _password,
                                      decoration: InputDecoration(
                                        label: Text("PASSWORD"),
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                            color: Colors.grey
                                        ),
                                        hintText: "******",
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: _focusNodes[3].hasFocus ? Colors.green : Colors.grey,
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
                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border:  _isPassMatch ? Border.all(width: 2, color: Colors.redAccent):Border.all(width: 0, color: Colors.transparent),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _focusNodes[4].hasFocus ? Colors.grey.shade200 : Colors.transparent,
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
                                      focusNode: _focusNodes[4],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appCollors.mainColors
                                      ),
                                      //  obscureText: !_passwordVisible,
                                      controller: _cPass,
                                      decoration: InputDecoration(
                                        label: Text("CONFIRM PASSWORD"),
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                            color: Colors.grey
                                        ),
                                        hintText: "******",
                                        prefixIcon: Icon(
                                          Icons.lock_person_outlined,
                                          color: _focusNodes[4].hasFocus ? Colors.green : Colors.grey,
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
                                          return "Confirm Password must not be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30,),
                              Bounce(
                                duration: Duration(milliseconds: 80),
                                onPressed: (){
                                  signupMethod();


                                },
                                child: AppButton(text: "Sign Up"),
                              ),

                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen())),
                                    child: const Text(
                                        "I have an account.", style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w100,
                                        fontFamily: "ThemeFont"
                                    )
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  TextButton(
                                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                                    child: Text('Login', style: TextStyle(
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

        ),
        _isLoading? LoadingFullScreen():Center(),
      ],
    );
  }

  Future signupMethod()async {
    var token = Random().nextInt(10000);
    print(token);
    print(_password.text);
    print(_cPass.text);
    setState(() {
      _isLoading = true;
    });

    if(_signUpKey.currentState!.validate()){

      if(_password.text == _cPass.text){

        //email check
        if(_email.text.contains("@")){

          if(_password.text.length > 7){

            //http response
            var signUpInfo = {
              "username" : _name.text,
              "email" : _email.text,
              "phone" : _number.text,
              "password" : _password.text,
            };
            //response
            var response = await http.post(Uri.parse(AppConfig.registration),
                body: signUpInfo
            );

            print(response.statusCode);

            if(response.statusCode == 200){
              //send otp by email
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification(email: _email.text, )));

            }else{
              var data = jsonDecode(response.body);
              print(response.body);
              print(response.body[0]);
              AppTost().errorTost(text: "The email has already been taken. Try another email.");

            }


          }else{
            //password
            setState(() {
              _isLoading  = false;
              _isPassValid  = true;
            });
            AppTost().errorTost(text: "The password must be at least 8 characters.");
          }


        }else{
          //email validation
          setState(() {
            _isLoading  = false;
            _isEmailValid  = true;
          });
          AppTost().errorTost(text: "The email must be a valid email address.");
        }
      }else{
       AppTost().errorTost(text: "Confirm Password do not match.");
        setState(() {
          _isLoading  = false;
          _isPassMatch = true;
        });
      }
    }
    setState(() {
      _isLoading  = false;
    });

  }

  loadingAlert() {
   return  SpinKitFoldingCube(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 3000)),
    );


  }




}

