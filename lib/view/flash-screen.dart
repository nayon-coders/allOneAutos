import 'package:car/view/home-screen.dart';
import 'package:car/view/sendotp.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import '../widgets/app-button.dart';
import 'login-screen.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  List sliderList = [
   // "assets/images/flas.gif",
    "assets/images/car-rent.png",
    "assets/images/car-repair.png",
    "assets/images/car-sell.png",
  ];
   int _current = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            height: height/1.8,
            width: width,
            child: CarouselSlider.builder(
              itemCount: sliderList.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(sliderList[itemIndex],),
                                fit: BoxFit.contain,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
              options: CarouselOptions(
                height: 350,
                aspectRatio: 16/9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),

          ),

          SizedBox(height: 20,),
          Text("Welcome to Xyz !",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "ThemeFont",
            ),
          ),
          SizedBox(height: 10,),

          SizedBox(
            width: width*.70,
            child:  Center(
              child: Text("With long experience in the industry, we create the best option for you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  fontFamily: "nunito",
                ),
              ),
            ),
          ),

          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Bounce(
                duration: Duration(milliseconds: 800),
                onPressed: ()=>Get.to(LoginScreen(), transition: Transition.zoom),
                child: const AppButton(text: "Get Start")),
          ),



        ],



      ),
    );
  }
}
