import 'dart:convert';

import 'package:car/app-config.dart';
import 'package:car/my-theme.dart';
import 'package:car/shared-prefarence.dart';
import 'package:car/view/login-screen.dart';
import 'package:car/view/profile-edit.dart';
import 'package:car/view/profile-setting.dart';
import 'package:car/view/sign-up-screen.dart';
import 'package:car/view/vendor/car-rent-vendor/car-rent-dashboard.dart';
import 'package:car/view/vendor/vendor-profile.dart';
import 'package:car/widgets/app-button.dart';
import 'package:car/widgets/toster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';
import '../view_controller/profile/user-profile-info.dart';
import '../view_controller/profile/user-profile-service-list.dart';
import '../view_controller/profile/vendor-profile-items.dart';
import '../widgets/loading-full-screen.dart';

class ProfileScreen extends StatefulWidget {
  final int vendorCreate;
  const ProfileScreen({this.vendorCreate = 0});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //================ User Login =================//

  @override
  void initState(){
    super.initState();
    getUserInfo = getLogin();
    
    if(widget.vendorCreate != 0){
      _showDialog();
    }



  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Lottie.asset("assets/images/success.json",
                  reverse: false,
                  repeat:  false,
                ),
                Text('Thank You for created your Car Rent Business Profile. You Car Rent Business Profile is Unlocked'),
                SizedBox(height: 20,),

                InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: appCollors.mainColors.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Text(
                        "OK",
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



  String? isLogin;
  var userInfo;
  late Future getUserInfo;
  var user_access;
  var carRent;
  var carSell;
  var carRepair;
  var carTowing;
  bool isLoading = false;
  getLogin()async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    isLogin = localDatabase.getString("isLogin");
    setState(() {
      isLoading = true;
    });
    var response = await ApiServices().userData();
    print(response.statusCode);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body)["data"];
      print(data);
      userInfo = data;
      carRent = data["user_access"]["car_rent"];
      //print(userInfo["user_access"]);
      print(userInfo);
      setState(() {
        isLoading = false;
      });
      return userInfo;
    }else{
      AppTost().successTost(text: "User not exits");
    }
    setState(() {
      isLoading = false;
    });
  }
  //================ User Login =================//



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xFFf3f3f3),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blueGrey,),
              onPressed: ()=>Navigator.pop(context),
            ),
            title: Text("General Profile", style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.blueGrey,),
                onPressed: ()=>Get.to(ProfileSetting()),
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [

                //================ User profile service list ============//
                ProfileServiceUserList(
                  onClick: (){},
                  leading:  Image.asset("assets/images/service-icon.png", height: 60, width: 60,),
                  title: "Service List",
                  trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.blueGrey,),

                ),
                SizedBox(height: 10,),
                ProfileServiceUserList(
                  onClick: () {  },
                  leading:  Image.asset("assets/images/search-car.png", height: 60, width: 60,),
                  title: "Find Your Car",
                  trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.blueGrey,),

                ),
                //================ User profile service list ============//

                SizedBox(height: 30,),
                Divider(height: 1, color: Colors.grey,),
                SizedBox(height: 30,),

                //=============== vendor text  ====================//
                 Column(
                  children: [
                    Text("You want to a vendor? ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w800
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                        child: Center(
                          child: Text("I have some ready Apps For upload In Play Console Account you have play Console Account Contact me.. thank You",
                           textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: "nunito",
                            ),
                          ),
                        ))
                  ],
                ),
                //=============== vendor text ====================//

                SizedBox(height: 20,),

                //=============== vendor ====================//
                 ProfileVendorItems(
                   size: size,
                   title: "Car Rent",
                   shortDec: ' In Play Console Account you have play Console Account Contact me.. thank You',
                   image: "assets/images/car-rent.png",
                   price: "29",
                   isCreated: carRent != null && carRent == "1" ? true : false,
                   onClick: (){
                     print(AppLocalDatabase.isLoginUser());
                     print("object");
                     if(isLogin == "1" &&  carRent != null && carRent == "1"){
                       Get.to(const CarRentDashboard(), transition: Transition.rightToLeft);
                       return;
                     }else if(isLogin == "1"){
                       Get.to(const VendorProfile(title: "Car Rent Vendor Profile", service: 1), transition: Transition.rightToLeft, duration: const Duration(milliseconds: 800));
                     }
                     else{
                       Get.to(CarRentDashboard(), transition: Transition.zoom);

                     }
                     print("object");
                   },
                   icon:   carRent != null && carRent == "1" ? Icons.dashboard: Icons.lock_outline_rounded,
                   buttonTitle:  carRent != null && carRent == "1" ? "Dashboard" : "Unlock Now",
                 ),
                 SizedBox(height: 10,),
                  ProfileVendorItems(
                    size: size,
                    title: "Car Repair Profile",
                    shortDec: 'I have some ready Apps For upload In Play Console Account you have play Console Account Contact me.. thank You',
                    image: "assets/images/car-repair-icon.png",
                    price: "29.98",
                    onClick: (){
                      if(userInfo["car_repair"] == "1"){
                        Get.to(const CarRentDashboard(), transition: Transition.rightToLeft);
                      }else if(isLogin == "1"){
                        Get.to(const VendorProfile(title: "Car Rent Vendor Profile", service: 1), transition: Transition.rightToLeft, duration: const Duration(milliseconds: 800));
                      }
                      else{
                        checkLogin();
                      }
                    },
                    icon: Icons.lock_outline_rounded,
                    buttonTitle: "Unlock Now",

                  ),
                 SizedBox(height: 10,),
                ProfileVendorItems(
                  size: size,
                  title: "Car Sell Profile",
                  shortDec: 'I have some ready Apps For upload In Play Console Acccount you have play Console Account Contact me.. thank You',
                  image: "assets/images/car-sell-icon.png",
                  price: "29.98",
                  onClick: (){},
                  icon: Icons.lock_outline_rounded,
                  buttonTitle: "Unlock Now",

                ),
                 SizedBox(height: 10,),
                ProfileVendorItems(
                  size: size,
                  title: "Car Towing Profile",
                  shortDec: 'I have some ready Apps For upload In Play Console Acccount you have play Console Account Contact me.. thank You',
                  image: "assets/images/car-towing-icon.png",
                  price: "29.98",
                  onClick: (){},
                  icon: Icons.lock_outline_rounded,
                  buttonTitle: "Unlock Now",
                ),
                //=============== vendor ====================//

                //=============== vendor ====================//
                //=============== vendor ====================//


                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
        isLoading ? LoadingFullScreen() : Center(),

      ],
    );
  }


  //=========== show vendor crete success =========//
  showCreteVendorSuccessPopup() async {
     showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Lottie.asset("assets/images/success.json",
                  reverse: false,
                  repeat:  false,
                ),
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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




class ActionInProfile{

   void uploadProfile(){
    print("================ upload profile =============");

  }

}
