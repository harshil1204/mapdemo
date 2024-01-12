import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static toastMsg(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
}

  static void flushBarErrorMessage(String message,BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(Icons.error,size: 28,color: Colors.white,),
          message: message,
          borderRadius: BorderRadius.circular(15),
          title: "Harshil",
          duration: const Duration(seconds: 3),
        )..show(context),
    );
  }

}