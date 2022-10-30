import 'dart:convert';

import 'package:car/app-config.dart';
import 'package:car/my-theme.dart';
import 'package:car/view/home-screen.dart';
import 'package:car/view/login-screen.dart';
import 'package:car/widgets/toster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../widgets/app-button.dart';
import '../widgets/big-title.dart';
import '../widgets/loading-full-screen.dart';
import 'package:http/http.dart' as http;
import '../widgets/small-sub-text.dart';

class Verification extends StatefulWidget {
  final String email;
  const Verification({Key? key, required this.email}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification>{
  var userCode;
  bool isLoading = false;
  bool resendEmail = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Scaffold(
          appBar: AppBar(
            bottom: resendEmail ? PreferredSize(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: appCollors.mainColors,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("We send a code again in your email.",
                        style: TextStyle(fontSize: 9.sp, color: Colors.white),
                        ),
                      InkWell(onTap: ()=>setState(()=>resendEmail = false),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 15.sp,
                          )
                      )
                    ],
                  ),
                ),
                preferredSize: Size( MediaQuery.of(context).size.width, 30)
            ):PreferredSize(
                child: Container(),
                preferredSize: Size( MediaQuery.of(context).size.width, 30)
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
              color: appCollors.mainColors,
              icon: const Icon(
                  Icons.arrow_back
              ),
            ),
            centerTitle: true,
            title:Text("Verification Code", style: TextStyle(fontSize: 10.sp, color: appCollors.mainColors),),

          ),

          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Center(child: BigTitle(title: "VERIFY CODE")),
                Center(child: SmallSubText(title: "Verify code sended")),
                SizedBox(height: 30,),
                Center(
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                          text: "We send code ",
                          style: TextStyle(color: Colors.grey)
                      ),
                      TextSpan(
                          text: "${widget.email}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      )
                    ],
                  )),
                ),
                SizedBox(height: 20,),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: appCollors.mainColors,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    setState(()=>  userCode = verificationCode);
                    checkOTP(userCode);
                  }, // end onSubmit
                ),
                SizedBox(height: 20,),

                Bounce(
                  duration: Duration(milliseconds: 80),
                  onPressed: ()=>checkOTP(userCode),
                  child: const AppButton(text: "Continue"),
                ),

                SizedBox(height: 20,),
                Center(
                  child: TextButton(
                    onPressed: (){
                          resendOTP();

                      },
                      child: Text("Resend Code"),
                  ),
                )

              ],
            ),
          ),
        ),

        isLoading ? LoadingFullScreen() : Center(),
      ],
    );
  }

  Future checkOTP(code)async{
    print(widget.email);
    print(code);

    //localhost
    SharedPreferences localDatabase = await SharedPreferences.getInstance(); 

    setState(() {
      isLoading = true;
    });
    var data = {
      'email': widget.email,
      'token': code,
    };
    var response = await http.post(Uri.parse(AppConfig.checkVerification),
      body: data,

    ) ;
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      AppTost().successTost(text: responseData["message"].toString());
      
      localDatabase.setString("token", responseData['data']["token"]);
      localDatabase.setString("isLogin", "1");

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(isSignup: 1,)));
    }else{
      var responseData = jsonDecode(response.body);
      AppTost().errorTost(text: responseData["message"].toString());
      print("Check Match");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    print(isLoading);
  }

  Future resendOTP() async{
    setState(() {
      isLoading = true;
    });

    var response = await http.post(Uri.parse(AppConfig.reendVerification),
      body: {"email":widget.email},
    ) ;
    if(response.statusCode == 200){
      setState(() {
        resendEmail = true;
      });
      AppTost().successTost(text: "Resend OTP you mail.");
    }else{
      AppTost().successTost(text: "This email is taken. Change your email. ");
      print("Check Match");

      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });



  }
}

