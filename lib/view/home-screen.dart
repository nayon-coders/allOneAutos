import 'dart:convert';
import 'dart:developer';

import 'package:car/my-theme.dart';
import 'package:car/services/car-rent-services.dart';
import 'package:car/view/car-rent-list.dart';
import 'package:car/view/car-repaier.dart';
import 'package:car/view/profile-screen.dart';
import 'package:car/view/profile-setting.dart';
import 'package:car/view/sign-up-screen.dart';
import 'package:car/view/single-car-rent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../notificationservice/notificationservice.dart';
import '../widgets/toster.dart';
import 'login-screen.dart';

class HomeScreen extends StatefulWidget {
  late  int? isSignup;
   HomeScreen({Key? key, this.isSignup}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin {
  late final AnimationController _controller;
  int _selectedIndex = 0;

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  final _search = TextEditingController();
  String? deviceTokenToSendPushNotification;
  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }



  @override
  void initState() {
    super.initState();

    isGone();
    _controller = AnimationController(vsync: this);
    getRentListFuture = getRentList();
    getDeviceTokenToSendNotification();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
           LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation:0.1,
        title: Text("AllOneAutos",
          style: TextStyle(
            fontSize: 15.sp,
            color: appCollors.mainColors,
            fontWeight: FontWeight.w900
          ),
        ),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.dashboard, ),
          color: appCollors.mainColors,
          iconSize: 20.sp,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.notifications_active, ),
                  color: appCollors.mainColors,
                  iconSize: 18.sp,
                ),
                Positioned(
                  right: 5,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: appCollors.mainColors,
                    ),
                    child: Center(child: Text("10", style: TextStyle(fontSize: 9.sp, color: appCollors.white, fontWeight: FontWeight.w900),)),
                  ),
                )
              ],
            ),
          ),
        ],
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              buildHomeSearch(),

              SizedBox(height: 20,),
              //================= services ================//
              Row(
                children: [
                  Container(
                    width: 5,
                    height: 20,
                    color: appCollors.mainColors,
                  ),
                  SizedBox(width: 10,),
                  Text("Our services",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  )
                ],
              ),


              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=>Get.to(CarRentList(), transition: Transition.rightToLeft),
                    child: buildHomeService(
                        name: "Car Rent",
                        image: "assets/images/car-rent.png",
                        size: size
                    ),
                  ),
                  buildHomeService(
                      name: "Car Sell",
                      image: "assets/images/car-sell.png",
                      size: size
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildHomeService(
                      name: "Car Repair",
                      image: "assets/images/car-repair.png",
                      size: size
                  ),
                  buildHomeService(
                      name: "Car Towing",
                      image: "assets/images/car-towing-icon.png",
                      size: size
                  )
                ],
              ),



              SizedBox(height: 30,),
              Container(
                width: size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: appCollors.mainColors
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width/1.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Instant Service",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15.sp,
                              color: appCollors.white
                            ),
                          ),
                          Text("You can get Instant Service for you Vehicles in your area.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                                color: appCollors.white
                            ),
                          )
                        ],
                      ),
                    ),

                    Lottie.asset("assets/images/instant-repair.json",
                      width: 70,
                      height: 70,
                      reverse: true,
                      repeat: true,
                    )

                  ],
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services_outlined),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: appCollors.mainColors,
        onTap: _onItemTapped,

      ),
    );
  }

  Container buildHomeService({required String name, required String image, required Size size}) {
    return Container(
              width: size.width/2.3,
              height: 130,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0,2)
                  )
                ],
              ),
              child: Column(
                children: [
                  Image.asset("$image",
                    height: 80,
                    width: 80,
                  ),
                  Center(
                    child: Text("$name",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),
            );
  }

  Container buildHomeSearch() {
    return Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: _focusNodes[0].hasFocus ? Colors.grey.shade300 : Colors.grey.shade200,
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
                    controller: _search,
                    decoration: InputDecoration(
                        hintText: "Find Towing Truck ",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: _focusNodes[0].hasFocus ? Colors.green : Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.location_searching,
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
            );
  }


  //====================== is Routing =================
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CarRepaier()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CarRepaier()));
        break;
      case 3:
        if(isLogin != "1"){
          checkLogin();
        }else{
          Get.to(ProfileScreen(), transition: Transition.rightToLeft);
        }
        break;
    }
  }
  //====================== is first time is gone =================
  //====================== is first time is gone =================
  void isGone(){
    Future.delayed(Duration(milliseconds: 7000), () {
      setState(() {
        widget.isSignup = 1;
      });
      // Do something
    });
  }//====================== is first time is gone =================


  Future<void> _makePhoneCall(String phoneNumber) async {
    print("object");
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  checkLogin() async {
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



class FirstTimeGone{

}
