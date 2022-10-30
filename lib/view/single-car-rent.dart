import 'dart:convert';

import 'package:car/my-theme.dart';
import 'package:car/services/car-rent-services.dart';
import 'package:car/services/services.dart';
import 'package:car/view/not-data-found.dart';
import 'package:car/widgets/toster.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../app-config.dart';

class SingleCarRet extends StatefulWidget {
  final String id;
  const SingleCarRet({Key? key, required this.id}) : super(key: key);

  @override
  State<SingleCarRet> createState() => _SingleCarRetState();
}

class _SingleCarRetState extends State<SingleCarRet> {

  //=========== get single car rent =============//
  late Future<void> futureSingleCarRent;
  getSingleRent()async{
    final response = await CarRentAPIService().getSingleCarRent(widget.id);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      AppTost().errorTost(text: "${response.statusCode} Error in API");
    }
  }

  @override
  void initState(){
    super.initState();
    futureSingleCarRent = getSingleRent();
    getUser = getUserInfo();
    areaCode.text = "12314";

  }

  //=============== get user data ===========;
  late Future<void> getUser;
  getUserInfo()async{
    var response = await ApiServices().userData();
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"];
      fullName.text = data["name"];
      email.text = data["email"];
      number.text = data["phone"];

      return data;
    }else{
      AppTost().errorTost(text: "${response.statusCode} Error in API");
      return;
    }
  }

  final fullName = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final areaCode = TextEditingController();

  bool isSending = false;
  bool msgEditing = false;

  var _testStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );




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
        title: Text("Details", style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: futureSingleCarRent,
          builder: (_, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: 250,
                          color: Colors.white,
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width:230,
                                    height: 30,

                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    color: Colors.white,
                                    width:230,
                                    height: 40,

                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: appCollors.mainColors.withOpacity(0.2),
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
                        ),

                        SizedBox(height: 30,),

                        Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            width: size.width,
                            decoration: BoxDecoration(

                              color: appCollors.white,
                                border: Border.all(width: 1, color: appCollors.mainColors)
                            ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: appCollors.white,
                              border: Border.all(width: 1, color: appCollors.mainColors)
                          ),
                        ),


                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: size.width,
                          decoration: BoxDecoration(
                            //color: appCollors.mainColors,
                              border: Border(
                                bottom: BorderSide(width: 1, color: appCollors.mainColors),
                                left: BorderSide(width: 1, color: appCollors.mainColors),
                                right: BorderSide(width: 1, color: appCollors.mainColors),
                              )
                          ),

                          child: Column(
                            children: [

                            ],

                          ),
                        )
                      ]
                  ),
                ),
              );
            }else if(snapshot.hasData){
              var data = snapshot.data["data"];
              name.text = data["name"];
              var msg = "Hello, My name is ${fullName.text} and i am interstate to this ${data["name"]}. I am in the ${areaCode.text} area. You cam reach me bu Email: ${email.text} or Phone Number: ${number.text}";

              return Container(
                width: size.width,
                padding: EdgeInsets.only(bottom: 20, ),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data["image"].length,
                        itemBuilder: (_, imageIndex){
                          var imagePath = data["image"][imageIndex]["file_path"].toString();
                          return
                            Image.network("${AppConfig.domain}/$imagePath", fit: BoxFit.cover, height: 200, width: size.width,);

                        },
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                        ),
                      ),
                      child: Center(
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ),

                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
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
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: appCollors.mainColors.withOpacity(0.2),
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
                    ),

                    SizedBox(height: 30,),

                    InkWell(
                       onTap: ()=> _makePhoneCall("+8801812569747"),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: size.width,
                        decoration: BoxDecoration(
                          //color: appCollors.mainColors,
                          border: Border.all(width: 1, color: appCollors.mainColors)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.phone, color: appCollors.mainColors, size: 15.sp,),
                            SizedBox(width: size.width/4,),
                            Center(
                              child: Text("+8801814569747",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: appCollors.mainColors
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: size.width,
                        decoration: BoxDecoration(
                          //color: appCollors.mainColors,
                            border: Border.all(width: 1, color: appCollors.mainColors)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.send, color: appCollors.mainColors, size: 15.sp,),

                            Text("Send Request",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: appCollors.mainColors
                              ),
                            ),

                            InkWell(
                               onTap: (){
                                 if(msgEditing == false){
                                   setState(() {
                                     msgEditing = true;
                                   });
                                 }else{
                                   setState(() {
                                     msgEditing = false;
                                   });
                                 }
                               },
                               child: Icon( msgEditing ? Icons.check : Icons.edit, color: appCollors.mainColors, size: 15.sp,)),

                          ],
                        ),
                      ),
                    ),


                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: size.width,
                      decoration: BoxDecoration(
                        //color: appCollors.mainColors,
                          border: Border(
                            bottom: BorderSide(width: 1, color: appCollors.mainColors),
                            left: BorderSide(width: 1, color: appCollors.mainColors),
                            right: BorderSide(width: 1, color: appCollors.mainColors),
                          )
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          msgEditing ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Hello, My name is ", style: _testStyle,),
                              Container(width: 150, height: 20,
                                child: TextFormField(
                                  controller: fullName,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: "${fullName.text}",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: Colors.grey)
                                      )

                                  ),
                                ),
                              ),
                              Text(" and", style: _testStyle,),
                            ],
                          ),

                          Text(" i am interstate to this ${name.text}. ", style: _testStyle,),
                          Row(
                            children: [
                              Text("I am in the ", style: _testStyle,),

                              Container(width: 100, height: 20,
                                margin: EdgeInsets.only(bottom: 5),
                                child: TextFormField(
                                  controller: areaCode,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: "${areaCode.text}",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: Colors.grey)
                                      )

                                  ),
                                ),
                              ),
                              Text(" area. You can reach ", style: _testStyle,),

                            ],
                          ),


                          Row(
                            children: [
                              Text("me by Email: ", style: _testStyle,),
                              Container(width: 220, height: 20,
                                margin: EdgeInsets.only(bottom: 5),
                                child: TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: "${email.text}",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: Colors.grey)
                                      )

                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("or by Phone Number: ", style: _testStyle,),
                              Container(width: 150, height: 20,
                                margin: EdgeInsets.only(bottom: 5),
                                child: TextFormField(
                                  controller: number,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: "${number.text}",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: Colors.grey)
                                      )

                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      )
                              : SizedBox(
                            width:size.width,
                            child: RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                  wordSpacing: 1.2,
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: 'Hello, My Name is '),
                                  TextSpan(text: '${fullName.text.toString()} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'and i am interstate to this '),
                                  TextSpan(text: '${data["name"]} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'I am in the '),
                                  TextSpan(text: '${areaCode.text} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'area. You can reach me by Email: '),
                                  TextSpan(text: '${email.text} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'or Phone Number: '),
                                  TextSpan(text: '${number.text}  \n\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "Thank You", style: const TextStyle(fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                      ),
                          

                          SizedBox(height: 40,),

                          InkWell(
                            onTap: ()=> sendRequest(
                                userID: "1",
                                vendorID: data["user_id"].toString(),
                                carID: data["id"].toString(),
                                msg: msg,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: appCollors.mainColors,
                                  border: Border.all(width: 1, color: appCollors.mainColors),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.email_outlined, color: appCollors.white, size: 15.sp,),
                                  SizedBox(width: size.width/4,),
                                  Center(
                                    child: isSending ? CircularProgressIndicator(
                                      color: appCollors.white,
                                      strokeWidth: 2,
                                    )
                                        :Text("SEND",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: appCollors.white
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),


                        ],

                      ),
                    )
                ]
                ),
              );
            }else{
              return NoDataFount();
            }
          },
        ),
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

  sendRequest({
    required String userID,
    required String vendorID,
    required String carID,
    required String msg,
  }) async{
    setState(() {
      isSending = true;
    });
    Map<String, dynamic> body = {
      "user_id" : userID,
      "vendor_id" : vendorID,
      "car_id" : carID,
      "message" : msg,
    };
    final response = await CarRentAPIService().sendCarRentRequest(body);

    print(response.statusCode);

    if(response.statusCode == 200){
      _showDialog();
    }else{
      AppTost().errorTost(text: "${response.statusCode} Error");
    }


    setState(() {
      isSending = false;
    });
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
                Lottie.asset("assets/images/success.json",
                  reverse: false,
                  repeat:  false,
                ),
                Text('Your Request is send to the Vendor. Check Notification or your email to see the request Update. Thank You. '),
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
}
