import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilities{

  //method to show a toast (positive or negative)
  static void showToast(String message, bool isPositive){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isPositive ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}