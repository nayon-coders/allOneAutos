import 'package:car/my-theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingFullScreen extends StatefulWidget {
  const LoadingFullScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingFullScreen> createState() => _LoadingFullScreenState();
}

class _LoadingFullScreenState extends State<LoadingFullScreen>{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.3),
      child :  SpinKitThreeBounce(
        color: appCollors.mainColors,
        size: 50.0,
      ),

    );
  }
}
