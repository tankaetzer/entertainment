import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

hideSpinner({
  bool animation = true,
}) {
  EasyLoading.dismiss(animation: animation);
}

void showSpinner({
  Color backgroundColor = Colors.white,
  Color spinnerColor = Colors.blue,
  Color textColor = Colors.black,
  double strokeWidth = 2.0,
  bool hasMessage = false,
  String loadingMessage = 'Loading...',
}) {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..radius = 12
    ..userInteractions = false
    ..contentPadding = EdgeInsets.all(20.0)
    ..textPadding = EdgeInsets.only(top: 20.0)
    ..fontSize = 12.0
    ..backgroundColor = backgroundColor
    ..indicatorColor = spinnerColor
    ..progressColor = spinnerColor
    ..textColor = textColor
    ..loadingStyle = EasyLoadingStyle.custom;
  EasyLoading.show(
    status: hasMessage ? loadingMessage : null,
    indicator: CircularProgressIndicator(),
  );
}
