import 'package:flutter/material.dart';

Widget infoWidget(String img, String title, String data) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Image.asset(
        'assets/images/$img',
        height: 40,
      ),
      Text(title),
      Text(data),
    ],
  );
}