import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_app/pages/login_page.dart';
import 'package:web_app/pages/register_page.dart';

void main() {
  runApp(MyWebApp());
}

class MyWebApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "myWebApp",
      home: RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
