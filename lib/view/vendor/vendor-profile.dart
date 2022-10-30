import 'dart:convert';
import 'dart:io';
import 'package:car/app-config.dart';
import 'package:car/view/profile-screen.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import 'package:car/services/services.dart';
import 'package:car/widgets/app-button.dart';
import 'package:car/widgets/toster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../widgets/loading-full-screen.dart';
class VendorProfile extends StatefulWidget {
  final String title;
  final int service;
  const VendorProfile({Key? key, required this.title, required this.service}) : super(key: key);

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {

  final _vendorKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _number = TextEditingController();
  final _bussName = TextEditingController();
  final _bussAddress = TextEditingController();
  final _bussEmail = TextEditingController();
  final _bussNumber = TextEditingController();

  bool _value = false;


  //================ User Login =================//
  String? defaultEmail;
  String? defaultPhone;
  String? userID;
  bool isChecked = false;
  bool isUseEmailForContact = false;
  String? _character;
  var UserInfo;
  Future getLogin()async{
    var response = await ApiServices().userData();
    print(response.statusCode);
    //print(response.body);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)["success"] ==true){
        UserInfo = jsonDecode(response.body)["data"];
        defaultEmail = UserInfo["email"];
        defaultPhone = UserInfo["phone"];
        userID = UserInfo["id"].toString();

        print(UserInfo);
        return UserInfo;
      }else{
        AppTost().errorTost(text: "User Not Found");
      }

    }else{
      AppTost().errorTost(text: "Something went wearing with Server");
    }


  }
  //================ User Login =================//

  @override
  void initState(){
    super.initState();
    getLogin();
  }
  isUseDefault(value){
    if(value == true){
      _bussEmail.text = defaultEmail!;
      _bussNumber.text = defaultPhone!;
    }else{
      _bussEmail.text = "";
      _bussNumber.text = "";
    }
  }
  bool _isProfileUpdate = false;
  final ImagePicker _picker = ImagePicker();
  File? businessLicence;
  File? businessStateLicence;
  bool isCarRentVendorCreating = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blueGrey,),
              onPressed: ()=>Navigator.pop(context),
            ),
            title: Text("${widget.title}", style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),),
            centerTitle: true,
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Column(
                children: [

                  Form(
                    key: _vendorKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Business Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 10,),
                        buildTextFormField("Business Name", "Business Name", _bussName),
                        SizedBox(height: 20,),
                        buildTextFormField("Business Address", "State, Country", _bussAddress),
                        SizedBox(height: 10,),

                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  isUseDefault(value);
                                });
                              },
                            ),
                            Text("Use Default Email & Number?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10,),
                        buildTextFormField("Business Email", "johan@gmail.com", _bussEmail ),
                        SizedBox(height: 20,),
                        buildTextFormField("Business Number", "+0 00000000", _bussNumber),
                        SizedBox(height: 20,),
                       Container(
                         width: size.width,
                         padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           color: Colors.white,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.shade200,
                               offset: Offset(0,2),
                               spreadRadius: 2,
                               blurRadius: 10
                             )
                           ],
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Use email for contact? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: Colors.black
                              ),
                             ),
                             Switch(
                               value: isUseEmailForContact,
                               onChanged: (bool value) {
                                 setState(() {
                                   isUseEmailForContact = value;
                                 });
                               },
                             ),
                           ],
                         ),
                       ),

                        SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap:()=>_showBottomNavigation(type: "business_licence"),
                              child: businessLicence != null ?
                              Container(
                                height: 150,
                                width: size.width/2.5,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Image.file(businessLicence!, fit: BoxFit.cover,),
                              )
                                  : Container(
                                height: 150,
                                width: size.width/2.5,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/upload.png", height: 100, width: 100,),
                                    Text("Business Licence",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: ()=>_showBottomNavigation(type: "state_licence"),
                              child: businessStateLicence != null ?
                              Container(
                                height: 150,
                                width: size.width/2.5,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Image.file(businessStateLicence!, fit: BoxFit.cover,),
                              ) : Container(
                                width: size.width/2.5,
                                height: 150,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/upload.png", height: 100, width: 100,),
                                    Text("State Licence",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30,),



                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar:  Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 20),
            child: InkWell(
                onTap: (){
                  print("object");
                  createCarRentVendor();
                },
                child: AppButton(text: "Continue")),

          ),

        ),
        isLoading ? LoadingFullScreen() : Center(),
      ],
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
                setState(() {
                  if(type == "business_licence") {
                    businessLicencePicker(ImageSource.camera);
                  }
                  if(type == "state_licence"){
                    businessStateLicencePicker(ImageSource.camera);
                  }
                });


                },
              ),
              ListTile(
                leading: new Icon(Icons.photo),
                title: const Text('From Gallery'),
                onTap: () {
                  setState(() {
                    if(type == "business_licence") {
                      businessLicencePicker(ImageSource.gallery);
                    }
                    if(type == "state_licence"){
                      businessStateLicencePicker(ImageSource.gallery);
                    }
                  });
                },
              ),
            ],
          );
        });

  }

  //================== Business Licence picker =================//
  Future businessLicencePicker(ImageSource imageType) async{
    print("object");
      setState(() {
        _isProfileUpdate = true;
        Navigator.pop(context);
      });
        try {
          final XFile? pickPhoto = await _picker.pickImage(source: imageType);
          if (pickPhoto == null){
            return;
          }else{
            setState(() {
              businessLicence = File(pickPhoto.path);
              print(businessLicence);
            });
           // return businessLicence;
          }
        }catch(e){
          print(e);
        }
      setState(() {
        _isProfileUpdate = false;
      });

    }
  //================== Business Licence picker =================//

  //================== Business State Licence picker =================//
  Future businessStateLicencePicker(ImageSource imageType) async{
    print("object");
    setState(() {
      _isProfileUpdate = true;
      Navigator.pop(context);
    });
    try {
      final XFile? pickPhoto = await _picker.pickImage(source: imageType);
      if (pickPhoto == null){
        return;
      }else{
        print("The file path is ===================${pickPhoto.path}");
        setState(() {
          businessStateLicence = File(pickPhoto.path);
        });
      }
    }catch(e){
      print(e);
    }
    setState(() {
      _isProfileUpdate = false;
    });

  }
  //================== Business Licence picker =================//

  //==================== file compress ====================//
  Future<File> compress({required File ImagePathTOComprose, quality: 100, percentage: 10})async{
    var path = FlutterNativeImage.compressImage(
        ImagePathTOComprose.absolute.path,
        quality: 80,
        percentage: 50
    );
    return path;

  }
  //==================== file compress ====================//



  //==================== crate vendor  ====================//
   createCarRentVendor() async{

     setState(() {
       isLoading  = true;
     });

     SharedPreferences localDatabase = await SharedPreferences.getInstance();
   var token = localDatabase.getString("token");
    var emailContact;
    setState(()=>isCarRentVendorCreating = true);

    //check input field is empty or not
    if(_vendorKey.currentState!.validate()){
      //check contact for email is empty or not
      if(isUseEmailForContact == true){
        setState(() {
          emailContact = "1";
        });
      }else{
        setState(() {
          emailContact = "0";
        });
      }

      //check business licence field is empty or not
      if(businessLicence == null){
        AppTost().errorTost(text: "Must be upload your Business Licence");
        setState(() => isLoading  =false,);
        return;
      }
      if(businessStateLicence == null){
        AppTost().errorTost(text: "Must be upload your Business State Licence");
        setState(() => isLoading  =false,);
        return;

      }

      Map<String, String> body = {
        "user_id" : userID.toString(),
        "business_address" : _bussAddress.text,
        "business_email" : _bussEmail.text,
        "business_phone" : _bussNumber.text,
        "use_email_for_contact" : isCarRentVendorCreating.toString(),
      };
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Accept" : "application/json",
        "Content-Type": "application/json"
      };

      // List<MultipartFile> newList = [
      //
      //   http.MultipartFile.fromPath('owner_state', businessStateLicence.toString())
      // ];
      // Map<String, dynamic> images = {
      //   await
      //   await http.MultipartFile.fromPath('owner_state', businessStateLicence.toString())
      // } as Map<String, dynamic>;

      print("response");

      var request = http.MultipartRequest('POST', Uri.parse(AppConfig.createCarRentVendor))
      ..headers.addAll(headers)
        ..fields.addAll(body)
        ..files.addAll( [
          await http.MultipartFile.fromPath('license', "${businessLicence!.path}"),
          await http.MultipartFile.fromPath('owner_state', "${businessStateLicence!.path}"),
        ]);
      var response = await request.send();
      print("Response ============== ${response.statusCode}");
      print("Response ============== ${response.stream}");

      if(response.statusCode == 200){
        AppTost().errorTost(text: "Profile created success");
        Get.to(ProfileScreen(vendorCreate: 1,), transition: Transition.fadeIn);
      }else{
        AppTost().errorTost(text: "Something went wrong with server API");
      }



      

    }else{
      print("some field is empty");
    }

    setState(() => isLoading  =false,);


  }
  //==================== crate vendor  ====================//








  //=================== text input field ===================/
  TextFormField buildTextFormField(
      @required String title,
      @required String hintText,
      @required TextEditingController controller) {

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text("${title}"),
          hintText: "$hintText",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Colors.grey)
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Field much not be empty";
        }else{
          return null;
        }
      },
    );
  }


}
