import 'package:av_app/styles/Styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastSeverity{
  Ok, NotOk
}
class ToastHelper {
  static void Show(String value, {ToastSeverity severity = ToastSeverity.Ok}) {

    Color color = primaryBlue1;
    String webColor = "#2C677B";
    if(severity!=ToastSeverity.Ok)
    {
      color = Colors.red;
      webColor  = "#d8392b";
    }
    Fluttertoast.showToast(msg: value, timeInSecForIosWeb: 3, webBgColor: webColor, backgroundColor: color);
  }
}