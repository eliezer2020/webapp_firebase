import "package:flutter/material.dart";

class Unknowpage extends StatelessWidget {
  final String routname;

  const Unknowpage({Key key, @required this.routname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //eliminar la primera letra
    final String parsedName = routname.substring(1);

    return Scaffold(
      body: Center(
          child: Text(
        "404 $parsedName not found",
        textScaleFactor: 8.0,
      )),
    );
  }
}
