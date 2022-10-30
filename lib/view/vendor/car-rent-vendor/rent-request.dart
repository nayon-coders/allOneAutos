import 'package:car/my-theme.dart';
import 'package:car/view/vendor/car-rent-vendor/rent%20request%20list/accept-rquest.dart';
import 'package:car/view/vendor/car-rent-vendor/rent%20request%20list/cancle-request.dart';
import 'package:car/view/vendor/car-rent-vendor/rent%20request%20list/pending-request.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'car-rent-dashboard.dart';
import 'car-rent-profile-edit.dart';
import 'drawer.dart';

class VendorRentRequestList extends StatefulWidget {
  final int? index;
  const VendorRentRequestList({Key? key, this.index}) : super(key: key);

  @override
  State<VendorRentRequestList> createState() => _VendorRentRequestListState();
}

class _VendorRentRequestListState extends State<VendorRentRequestList> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CarRentVendorDrawer(size: size),
        appBar: AppBar(
          backgroundColor: appCollors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon: Icon(Icons.arrow_back_ios_new, color: appCollors.black54,),
          ),
          title: Text("Car Rent Request",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: appCollors.black,
              fontSize: 15.sp,
            ),
          ),
          bottom: const TabBar(
            labelColor: appCollors.mainColors,
            labelStyle: TextStyle(fontWeight: FontWeight.w900),
            indicatorColor: appCollors.mainColors,
            unselectedLabelColor: Colors.black54,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
            tabs: [
              Tab(text: "Pending",),
              Tab(text: "Active"),
              Tab(text: "Cancel"),
              Tab(text: "Archive"),
            ],
          ),

        ),

        body: const TabBarView(
          children: [
            PendingRentList(),
            AcceptRentList(),
            CancelRentList(),
            CancelRentList(),
          ],
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
