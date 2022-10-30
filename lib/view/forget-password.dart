import 'package:car/my-theme.dart';
import 'package:car/view/verify-email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';

import '../widgets/app-button.dart';
import '../widgets/big-title.dart';
import '../widgets/small-sub-text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _email = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title:Text("Forget Password", style: TextStyle(fontSize: 10.sp, color: appCollors.mainColors),),

      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(child: BigTitle(title: "FORGET PASSWORD")),
            Center(child: SmallSubText(title: "Forget your password")),
            SizedBox(height: 30,),
            Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10,),
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
                                return "Email must not be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Bounce(
                      duration: Duration(milliseconds: 80),
                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification(email: _email.text,))),
                      child: const AppButton(text: "Send Code"),
                    ),

                    SizedBox(height: 20,),



                  ],
                ))

          ],
        ),
      ),


    );
  }
}
