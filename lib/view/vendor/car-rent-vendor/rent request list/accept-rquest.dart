import 'dart:convert';

import 'package:car/my-theme.dart';
import 'package:car/view/not-data-found.dart';
import 'package:car/view/vendor/car-rent-vendor/rent-history.dart';
import 'package:expandable/expandable.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../services/car-rent-services.dart';
import '../../../../widgets/toster.dart';
import '../../widget/status-button.dart';

class AcceptRentList extends StatefulWidget {
  const AcceptRentList({Key? key}) : super(key: key);

  @override
  State<AcceptRentList> createState() => _AcceptRentListState();
}

class _AcceptRentListState extends State<AcceptRentList> {
  @override
  initState(){
    super.initState();
    futureGetRentRequest = getRentRequest();
  }


  bool dataLength = false;

  //======== api =======//
  late Future futureGetRentRequest;
  getRentRequest()async{
    var response = await CarRentAPIService().getPendingRentList();
    if(response.statusCode == 200){
      print(jsonDecode(response.body));
      return jsonDecode(response.body)["data"];
    }else{
      AppTost().errorTost(text: "${response.statusCode} Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
        future: futureGetRentRequest,
        builder: (_, AsyncSnapshot<dynamic>snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index){
                return Shimmer.fromColors(
                  highlightColor: Colors.grey.shade300,
                  baseColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10,),
                    padding: EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
                    width: size.width,
                    height: 40,
                  ),
                );
              },

            );
          }else if(snapshot.hasData){
            if(snapshot.data.length != 0){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){
                  var data = snapshot.data[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10  ,),
                    padding: EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey.shade300)
                        ),
                        color: Colors.green.shade100.withOpacity(0.1)
                    ),
                    child: ExpandablePanel(
                      header: Text('${data["car"]["name"]}', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
                      collapsed: Text("${data["message"]}", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      expanded: Column(
                        children: [
                          Text("${data["message"]}", softWrap: true, ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StatusButton(
                                title: "History",
                                icon: Icons.history,
                                color: Colors.green.shade700,
                                onClick: ()=>Get.to(SingleRentHistory(), transition: Transition.rightToLeft),
                              ),
                            ],
                          ),


                        ],
                      ),

                    ),
                  );
                },

              );
            }else{
              print("object");
              return NoDataFount();
            }

            return Text("af");
          }else{
            return NoDataFount();
          }
        },

      ),
    );
  }
}

