import 'package:car/my-theme.dart';
import 'package:car/view/profile-screen.dart';
import 'package:car/view/vendor/car-rent-vendor/rent-request.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarRentVendorDrawer extends StatelessWidget {
  const CarRentVendorDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            Container(
              width: size.width,
              height: 300,
              padding: EdgeInsets.only(top: 50, bottom: 30, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: appCollors.mainColors
              ),
              child: Column(
                children: [
                  Container(
                    width:100,
                    height: 100,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: appCollors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text("N", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Nayon Talukder",
                    style: TextStyle(
                        color: appCollors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("nayon.coders@gmail.com",
                    style: TextStyle(
                        color: appCollors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                  ),

                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: ()=>Get.to(ProfileScreen(), transition: Transition.zoom),
            ),
            Divider(height: 1, color: Colors.grey,),
            ListTile(
              leading: Icon(Icons.list_alt_sharp),
              title: Text('Request List'),
              onTap: ()=>Get.to(VendorRentRequestList(index:1), transition: Transition.zoom),

            ),
            ListTile(
              leading: Icon(Icons.list_alt_sharp),
              title: Text('Add Payment Method'),
              onTap: ()=>Get.to(VendorRentRequestList(index:1), transition: Transition.zoom),
            ),
            ListTile(
              leading: Icon(Icons.list_alt_sharp),
              title: Text('Manage Payment'),
              onTap: ()=>Get.to(VendorRentRequestList(index:2), transition: Transition.zoom),
            ),

          ],
        ));
  }
}
