import 'dart:convert';

import 'package:car/my-theme.dart';
import 'package:car/services/car-rent-services.dart';
import 'package:car/view/not-data-found.dart';
import 'package:car/view/vendor/car-rent-vendor/car-rent-profile-edit.dart';
import 'package:car/widgets/toster.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'drawer.dart';

class CarRentDashboard extends StatefulWidget {
  const CarRentDashboard({Key? key}) : super(key: key);

  @override
  State<CarRentDashboard> createState() => _CarRentDashboardState();
}

class _CarRentDashboardState extends State<CarRentDashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int currentTab = 0;
  String? rec;
  Map<String, double> dataMap = {
    "Pending": 5,
    "Accept": 5,
    "Cancel": 3,
  };
  final colorList = <Color>[
    Colors.blueAccent,
    Colors.green,
    Colors.red,
  ];

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 60),
    _SalesData('July', 90),
    _SalesData('Aug', 50),
    _SalesData('Sep', 190),
    _SalesData('Oct', 100),
    _SalesData('Nov', 30),
    _SalesData('Dec', 10),
  ];

  @override
  initState(){
    super.initState();
    futureGetRentRequest = getRentRequest();
  }


  //======== api =======//
  late Future futureGetRentRequest;
   getRentRequest()async{
    var response = await CarRentAPIService().getCarRentRequestList();
    if(response.statusCode == 200){
      print(jsonDecode(response.body));
      rec = jsonDecode(response.body)["message"];
      print(rec);
      return jsonDecode(response.body)["data"];
    }else{
      AppTost().errorTost(text: "${response.statusCode} Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold( 
        key: _scaffoldKey,
        drawer: CarRentVendorDrawer(size: size),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appCollors.mainColors,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 0, bottom: 80),
                        child: Text("Dashboard",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: appCollors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 150,
                      padding: EdgeInsets.all(15),
                      transform: Matrix4.translationValues(0.0, 100.0, 0.0),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appCollors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Short View",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset("assets/images/chart1.png", height: 50, width: 50,),



                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),



            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: appCollors.mainColors,
          child: Icon(Icons.home_filled),
          onPressed: ()=>Get.to(CarRentDashboard(), transition: Transition.zoom),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      _scaffoldKey.currentState?.openDrawer();

                      // Get.to(Favorite(), transition: Transition.rightToLeft);
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.menu,
                        color:Colors.grey,
                      ),
                      Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      Get.to(VendorRentProfileEdit(), transition: Transition.rightToLeft);
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        color: appCollors.grey,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: appCollors.grey,
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),

      ),
    );
  }

  void statusChange({required int statusID, required int id})async {

  }
}


class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}