import 'dart:convert';

import 'package:car/app-config.dart';
import 'package:car/my-theme.dart';
import 'package:car/services/car-rent-services.dart';
import 'package:car/services/services.dart';
import 'package:car/view/login-screen.dart';
import 'package:car/view/not-data-found.dart';
import 'package:car/view/sign-up-screen.dart';
import 'package:car/view/single-car-rent.dart';
import 'package:car/widgets/toster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CarRentList extends StatefulWidget {
  const CarRentList({Key? key}) : super(key: key);

  @override
  State<CarRentList> createState() => _CarRentListState();
}

class _CarRentListState extends State<CarRentList> {


  @override
  void initState(){
    super.initState();
    getRentListFuture = getRentList();
  }

  //car rent list//
  late Future getRentListFuture;
  var carRentList;
  String? isLogin;
  getRentList()async{
      SharedPreferences localDatabase = await SharedPreferences.getInstance();
      isLogin = localDatabase.getString("isLogin");

    final response = await CarRentAPIService().getCarRentList();
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      carRentList = data;
      print(carRentList);
      return carRentList;

    }else{
      AppTost().errorTost(text: "Something went worng with API Server");
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey,),
          onPressed: ()=>Navigator.pop(context),
        ),
        title: Text("Rent Car List", style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        child: FutureBuilder(
          future: getRentListFuture,
          builder: (_, AsyncSnapshot<dynamic> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
               return ListView.builder(
                 itemCount: 4,
                 itemBuilder: (_, index){
                   return Container(
                     width: size.width,
                     height: 380,
                     margin: EdgeInsets.only(bottom: 25),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                             color: Colors.grey.shade200,
                             spreadRadius: 2, blurRadius: 10, offset: Offset(0,2)
                         )
                       ],
                     ),
                     child: Shimmer.fromColors(
                       baseColor: Colors.grey.shade300,
                       highlightColor: Colors.grey.shade100,
                       child: Column(

                         children: [
                           Container(
                             width: size.width,
                             height: 120,
                             color: Colors.white,
                           ),
                           SizedBox(height: 20,),
                           Padding(
                             padding: EdgeInsets.all(20),
                             child:Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   width: size.width,
                                   height: 20.0,
                                   color: Colors.white,
                                 ),
                                 SizedBox(height: 10,),
                                 Container(
                                   width: 200,
                                   height: 20.0,
                                   color: Colors.white,
                                 ),
                                 SizedBox(height: 15,),
                                 Container(
                                   width: size.width,
                                   height: 20.0,
                                   color: Colors.white,
                                 ),
                                 SizedBox(height: 5,),
                                 Container(
                                   width: size.width,
                                   height: 20.0,
                                   color: Colors.white,
                                 ),

                                 SizedBox(height: 30,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Column(
                                       children: [
                                         Container(
                                           width:100,
                                           height: 20.0,
                                           color: Colors.white,
                                         ),
                                         SizedBox(height: 5,),
                                         // InkWell(
                                         //   onTap: (){
                                         //     _makePhoneCall("+8801812569747");
                                         //   },
                                         //   child: Text("nayon@gmail.com",
                                         //     style: TextStyle(
                                         //       fontSize: 11.sp,
                                         //       fontWeight: FontWeight.bold,
                                         //         color: Colors.lightBlue
                                         //     ),
                                         //   ),
                                         // ),
                                       ],
                                     ),
                                     Container(
                                       width: 130,
                                       height: 40.0,
                                       color: Colors.white,
                                     ),
                                   ],
                                 )
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                   );
                 },
               );
              }else if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data["data"].length,
                  itemBuilder: (_, index){
                    var data = snapshot.data["data"][index];
                    return Container(
                      width: size.width,
                      margin: EdgeInsets.only(bottom: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2, blurRadius: 10, offset: Offset(0,2)
                          )
                        ],
                      ),
                      child: Column(

                        children: [
                          Container(
                            width: size.width,
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data["image"].length,
                              itemBuilder: (_, imageIndex){
                                var imagePath = data["image"][imageIndex]["file_path"].toString();
                                return
                                    Image.network("${AppConfig.domain}/$imagePath", fit: BoxFit.cover, height: 200, width: size.width/1.1,);

                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       SizedBox(
                                         width:230,
                                         child: Text("${data["name"]}",
                                           overflow: TextOverflow.clip,
                                           style: TextStyle(
                                             fontSize: 12.sp,
                                             fontWeight: FontWeight.w800,
                                           ),
                                         ),
                                       ),
                                       SizedBox(height: 10,),
                                       Text("\$ ${data["price"]}",
                                         style: TextStyle(
                                           fontSize: 15.sp,
                                           fontWeight: FontWeight.w900,
                                         ),
                                       ),
                                     ],
                                   ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: IconButton(
                                        color: appCollors.mainColors,
                                        icon: Icon(Icons.favorite_border_outlined,),
                                        onPressed: (){},
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.speed,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5,),
                                    Text("${data["mileage"]}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5,),
                                    Text("${data["location"]} (13 mi)",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            if(isLogin != "1"){
                                              _showDialog();
                                            }else{
                                              _makePhoneCall("+8801812569747");
                                            }

                                          },
                                          child: Text("+8801814569747",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightBlue
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        // InkWell(
                                        //   onTap: (){
                                        //     _makePhoneCall("+8801812569747");
                                        //   },
                                        //   child: Text("nayon@gmail.com",
                                        //     style: TextStyle(
                                        //       fontSize: 11.sp,
                                        //       fontWeight: FontWeight.bold,
                                        //         color: Colors.lightBlue
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: (){
                                        if(isLogin != "1"){
                                        _showDialog();
                                        }else{
                                             Get.to(SingleCarRet(id: data["id"].toString()), transition: Transition.rightToLeft);
                                        }
                                      },
                                        child: Container(
                                                  width: 130,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: appCollors.mainColors, width: 1)
                                                  ),
                                                  child: Center(
                                                        child: Text("Request",
                                                     style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: appCollors.mainColors,
                                                      fontWeight:
                                                     FontWeight.w600
                                                   ),
                                                 ),
                                                ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }else{
                return NoDataFount();
              }

          },
        )
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    print("object");
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 20));
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Lottie.asset("assets/images/login-first.json",
                  reverse: false,
                  repeat:  false,
                ),
                Text('You have to login is First before gating services'),
                SizedBox(height: 20,),

                TextButton(
                  onPressed: ()=>Get.to(SignUpScreen(), transition: Transition.fadeIn),
                  child: Text("I don't have account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: appCollors.mainColors
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=>Get.to(LoginScreen(), transition: Transition.fadeIn),
                  child: Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: appCollors.mainColors.withOpacity(0.2),
                    ),
                    child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: appCollors.mainColors
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
          ),

        );
      },
    );
  }
}
