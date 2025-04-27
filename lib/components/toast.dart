import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast({
  required String msg,
  Toast? toastLength = Toast.LENGTH_SHORT,
  ToastGravity? gravity = ToastGravity.BOTTOM,
  Color? backgroundColor = Colors.black87,
  Color? textColor = Colors.white,
  double? fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength!,
    gravity: gravity!,
    backgroundColor: backgroundColor!,
    textColor: textColor!,
    fontSize: fontSize!,
  );
}
