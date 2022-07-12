import 'package:flutter/material.dart';

AppBar getAppbar(String title, BuildContext context,
    {Color bgColor = Colors.green, PreferredSizeWidget? bottom}) {
  return AppBar(
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevation: 4,
    bottom: bottom,
    title: Text(title),
    backgroundColor: bgColor,
  );
}
