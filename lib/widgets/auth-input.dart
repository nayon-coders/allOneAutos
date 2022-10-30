import 'package:car/my-theme.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  const AuthInput({Key? key, required this.title, required this.controller, required this.hint, this.isPassword = false}) : super(key: key);

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  late bool _passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0,3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.title}",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontFamily: "RobotoSmall",
                color: appCollors.black
            ),
          ),

          TextFormField(
          //  obscureText: !_passwordVisible,
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: "{widget.hint}",
                label: Text("sdaf"),
                prefixIcon: Icon(
                  Icons.lock_outline,
                ),
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: widget.isPassword ? IconButton(
                  icon: Icon(
                      _passwordVisible ?  Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: appCollors.black
                  ), onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                ) : Center(),

                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200
                )
            ),
          )
        ],
      ),
    );
  }
}
