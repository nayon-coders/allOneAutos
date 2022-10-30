import 'package:car/my-theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class ProfileVendorItems extends StatelessWidget {
  const ProfileVendorItems({
    Key? key,
    required this.size, required this.title, required this.shortDec, required this.image, required this.onClick, required this.price, required this.icon, required this.buttonTitle,  this.isCreated = false,
  }) : super(key: key);

  final Size size;
  final String title;
  final String shortDec;
  final String image;
  final String price;
  final VoidCallback onClick;
  final IconData icon;
  final String buttonTitle;
  final bool isCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: isCreated ? BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appCollors.mainColors
      ) : BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF07A44F),
            const Color(0xFFFFB800),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width/1.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title,
                          style: TextStyle(
                              fontFamily: "nunito",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(width: 5,),
                       isCreated ? Container(
                         padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3,),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(100)
                         ),
                         child: Center(
                           child: Text("Active",
                            style: TextStyle(
                              color: appCollors.mainColors,
                              fontSize: 8.sp,
                            ),
                           ),
                         ),
                       ) : Icon(Icons.lock, size: 10.sp,)
                      ],
                    ),
                    Text(shortDec,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontFamily: "nunito",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Image.asset(image, height: 80, width: 80,)
            ],
          ),

          // SizedBox(height: 10,),
          //
          // SizedBox(
          //   width: size.width,
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           Row(
          //             children: [
          //               Icon(Icons.check_circle, size: 18, color: Colors.white,),
          //               SizedBox(width: 5,),
          //               Text("Create rent profile",
          //                 style: TextStyle(
          //                   fontSize: 10.sp,
          //                   fontWeight: FontWeight.w400,
          //                   fontFamily: "nunito",
          //                   color: Colors.white
          //                 ),
          //               )
          //             ],
          //           ),
          //           SizedBox(width: 20,),
          //           Row(
          //             children: [
          //               Icon(Icons.check_circle, size: 18, color: Colors.white,),
          //               SizedBox(width: 5,),
          //               Text("Submit your car information",
          //                 style: TextStyle(
          //                     fontSize: 10.sp,
          //                     fontWeight: FontWeight.w400,
          //                     fontFamily: "nunito",
          //                     color: Colors.white
          //                 ),
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 7,),
          //       Row(
          //         children: [
          //           Icon(Icons.check_circle, size: 18, color: Colors.white,),
          //           SizedBox(width: 5,),
          //           Text("Make Money ",
          //             style: TextStyle(
          //                 fontSize: 10.sp,
          //                 fontWeight: FontWeight.w400,
          //                 fontFamily: "nunito",
          //                 color: Colors.white
          //             ),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onClick,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isCreated ? Colors.white: Colors.black.withOpacity(0.3),
                  ),
                  child: Row(
                    children:[
                      Icon(icon, color: isCreated ? appCollors.mainColors : Colors.white, size: 20,),
                      SizedBox(width: 10,),
                      Text("$buttonTitle",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: isCreated ? appCollors.mainColors : Colors.white
                      ),
                    ),
                  ]
                  ),
                ),
              ),

              isCreated ?  RichText(
                  text: TextSpan(
                    children: [

                      TextSpan(
                          text: "Expire: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: Colors.white,
                          )
                      ),
                      TextSpan(
                          text: "20 Jun 2022",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                            color: Colors.white,
                          )
                      ),
                    ],
                  )) : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "\$$price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: Colors.white,
                          )
                      ),
                      TextSpan(
                          text: "/Mon",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: Colors.white,
                          )
                      )
                    ],
                  ))
            ],
          )




        ],
      ),
    );
  }
}
