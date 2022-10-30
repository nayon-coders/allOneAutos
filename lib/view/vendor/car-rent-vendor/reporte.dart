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

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
    return Scaffold(
      key: _scaffoldKey,
      drawer: CarRentVendorDrawer(size: size),
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: appCollors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: appCollors.black54,),
        ),
        title: Text("Car Rent Data Analysis",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: appCollors.black,
            fontSize: 15.sp,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: size.width,
                  height: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: appCollors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: Colors.grey.shade200
                      )
                    ],
                  ),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),

                      title: ChartTitle(
                          text: "Yearly Request Analysis",
                          textStyle: TextStyle(
                              fontSize: 10.sp,
                              color: appCollors.black
                          )
                      ),

                      series: <ChartSeries<_SalesData, String>>[
                        ColumnSeries<_SalesData, String>(
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) => sales.year,
                            yValueMapper: (_SalesData sales, _) => sales.sales,

                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true)
                        )
                      ])


              ),
              SizedBox(height: 20,),
              Container(
                width: size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appCollors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0,2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.grey.shade200
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 5,
                              height: 20,
                              color: appCollors.mainColors,
                            ),
                            SizedBox(width: 10,),
                            Text("See Request",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.calendar_month),
                          color: appCollors.mainColors,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          height: 60,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Text("12",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green
                                ),
                              ),
                              Text("Approve",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 60,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Text("12",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue
                                ),
                              ),
                              Text("Pending",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 60,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Text("12",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red
                                ),
                              ),
                              Text("Cancel",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),


                    PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: colorList,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 32,
                      centerText: "Driver \nRequest",
                      legendOptions: LegendOptions(
                        showLegends: false,

                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValues: false,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Container(
                width: size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appCollors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0,2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.grey.shade200
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 5,
                              height: 20,
                              color: appCollors.mainColors,
                            ),
                            SizedBox(width: 10,),
                            Text("Driver Request",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: (){},
                          child: Text("VIEW ALL",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 10.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(height: 1, color: Colors.grey.shade300,),
                    SizedBox(height: 10,),
                    FutureBuilder(
                      future: futureGetRentRequest,
                      builder: (_, AsyncSnapshot<dynamic> snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Text("adfa");
                        }else if(snapshot.hasData){
                          if(snapshot.data.length != 0){

                            return Container(
                              width: size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),

                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index){
                                  var data = snapshot.data[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 1, color: Colors.grey.shade300)
                                        )
                                    ),
                                    child: ExpandablePanel(
                                      header: Text("${data["car"]["name"]}", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
                                      collapsed: Text("${data["message"]}", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      expanded: Column(
                                        children: [
                                          Text("${data["message"]}", softWrap: true, ),

                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  statusChange(statusID : 1, id: data["id"]);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 20, right: 20, top:5, bottom: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                  child: Center(
                                                    child: Text("Approve",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: appCollors.white
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap:(){
                                                  statusChange(statusID : 1, id: data["id"]);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 20, right: 20, top:5, bottom: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                  child: Center(
                                                    child: Text("Cancel",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: appCollors.white
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),

                                    ),
                                  );
                                  // return Container(
                                  //     width: size.width,
                                  //     margin: EdgeInsets.only(bottom: 20),
                                  //     padding: EdgeInsets.only( bottom: 20),
                                  //     decoration: BoxDecoration(
                                  //       color: appCollors.white,
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         SizedBox(
                                  //           width:size.width,
                                  //           child: Text("${data["car"]["name"]}",
                                  //             overflow: TextOverflow.ellipsis,
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.w600,
                                  //                 color: appCollors.black,
                                  //                 fontSize: 13.sp
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         SizedBox(height: 5,),
                                  //         Text("${data["message"]}",
                                  //           overflow: TextOverflow.clip,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.w400,
                                  //               color: appCollors.black,
                                  //               fontSize: 9.sp
                                  //           ),
                                  //         ),
                                  //         SizedBox(height: 20,),
                                  //         Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             InkWell(
                                  //               onTap:(){
                                  //                 statusChange(statusID : 1, id: data["id"]);
                                  //               },
                                  //               child: Container(
                                  //                 padding: EdgeInsets.only(left: 20, right: 20, top:5, bottom: 5),
                                  //                 decoration: BoxDecoration(
                                  //                   color: Colors.green,
                                  //                   borderRadius: BorderRadius.circular(100),
                                  //                 ),
                                  //                 child: Center(
                                  //                   child: Text("Approve",
                                  //                     style: TextStyle(
                                  //                         fontSize: 12.sp,
                                  //                         color: appCollors.white
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             InkWell(
                                  //               onTap:(){
                                  //                 statusChange(statusID : 1, id: data["id"]);
                                  //               },
                                  //               child: Container(
                                  //                 padding: EdgeInsets.only(left: 20, right: 20, top:5, bottom: 5),
                                  //                 decoration: BoxDecoration(
                                  //                   color: Colors.red,
                                  //                   borderRadius: BorderRadius.circular(100),
                                  //                 ),
                                  //                 child: Center(
                                  //                   child: Text("Cancel",
                                  //                     style: TextStyle(
                                  //                         fontSize: 12.sp,
                                  //                         color: appCollors.white
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     )
                                  // );
                                },
                              ),
                            );

                          }else{
                            print("object");
                            return NoDataFount();
                          }
                        }else{
                          return Center(child: Text("API Error"),);
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),



            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: appCollors.mainColors,
        child: Icon(Icons.home_filled),
        onPressed: ()=>Get.to(Report(), transition: Transition.zoom),
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