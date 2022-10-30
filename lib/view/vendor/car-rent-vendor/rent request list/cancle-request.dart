import 'dart:convert';

import 'package:car/my-theme.dart';
import 'package:car/view/not-data-found.dart';
import 'package:expandable/expandable.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../services/car-rent-services.dart';
import '../../../../widgets/toster.dart';
import '../../widget/status-button.dart';

class CancelRentList extends StatefulWidget {
  const CancelRentList({Key? key}) : super(key: key);

  @override
  State<CancelRentList> createState() => _CancelRentListState();
}

class _CancelRentListState extends State<CancelRentList> {
  @override
  initState(){
    super.initState();
    futureGetRentRequest = getRentRequest();
  }


  bool dataLength = false;

  //======== api =======//
  late Future futureGetRentRequest;
  getRentRequest()async{
    var response = await CarRentAPIService().getCancelRentList();
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
                  highlightColor: Colors.grey.shade100,
                  baseColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10,),
                    padding: EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
                    width: size.width,
                    height: 60, 
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
                    margin: EdgeInsets.only(bottom: 10,),
                    padding: EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey.shade300)
                        ),
                        color: Colors.red.shade100.withOpacity(0.3),
                    ),
                    child: ExpandablePanel(
                      header: Text('${data["car"]["name"]}', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
                      collapsed: Text("${data["message"]}", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      expanded: Column(
                        children: [
                          Text("${data["message"]}", softWrap: true, ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              StatusButton(
                                title: "Delete",
                                icon: Icons.delete  ,
                                color: Colors.red.shade700,
                                onClick: (){},
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

