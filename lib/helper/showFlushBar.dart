import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void showError(String data, BuildContext context) {
  Flushbar(
    message: data,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue[300],
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.blue[300],
  ).show(context);
}
