import 'package:car/my-theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'car-rent-dashboard.dart';
import 'car-rent-profile-edit.dart';
import 'drawer.dart';

class SingleRentHistory extends StatefulWidget {
  const SingleRentHistory({Key? key}) : super(key: key);

  @override
  State<SingleRentHistory> createState() => _SingleRentHistoryState();
}

class _SingleRentHistoryState extends State<SingleRentHistory> {
  int currentTab = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CarRentVendorDrawer(size: size),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: size.width,
                height: 200,
                padding: EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: appCollors.mainColors
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: ()=>Get.back(),
                          icon: Icon(Icons.arrow_back_ios_new),
                          color: Colors.white,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Stay on top of your money",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("See, how you're doing",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w200
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 30,),
              Center(
                child: Text("You're Money",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),

                ),
              ),

              SizedBox(height: 20,),


              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("TOTAL",
                          style: TextStyle(
                            color: appCollors.mainColors,
                            fontSize: 9.sp,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("\$1450",
                          style: TextStyle(
                            color: appCollors.mainColors,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("PAID",
                          style: TextStyle(
                            color: appCollors.mainColors,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 50,
                      color: Colors.grey.shade400,
                    ),
                    Column(
                      children: [
                        Text("PENDING",
                          style: TextStyle(
                            color: appCollors.mainColors,
                            fontSize: 9.sp,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("\$145",
                          style: TextStyle(
                              color: appCollors.mainColors,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("PAYING",
                          style: TextStyle(
                            color: appCollors.mainColors,
                            fontSize: 9.sp,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only( top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.grey.shade300),
                      bottom: BorderSide(width: 1, color: Colors.grey.shade300),
                    )
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.pending_actions,
                    ),
                    title: Text("Next payment date"),
                    trailing: Text("12 Nov 2022",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: appCollors.mainColors
                      ),
                    ),
                  )
                ),
              ),
              SizedBox(height: 30,),
              Padding(padding: EdgeInsets.only(left: 20, right: 20),
                child: Text("Recent Activated",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.sp
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: 10,
                  itemBuilder: (_, index){
                   return  ListTile(
                     title: Text("Online Pay (From Driver)"),
                     subtitle: Text("30-09-22"),
                     trailing: Text("\$120.00",
                       style: TextStyle(
                           color: appCollors.mainColors,
                           fontWeight: FontWeight.w800
                       ),
                     ),
                   );
                  },
                ),
              ),
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
}
