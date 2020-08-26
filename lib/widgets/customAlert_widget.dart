import 'package:flutter/material.dart';

onAlertAutentication(BuildContext context, String text) {
  showDialog(
      context: context,
      child: SimpleDialog(
        title: Center(
          child: Text(text),
        ),
      ));
}

onErrorAuth(BuildContext context, String error) {
  showDialog(
      context: context,
      child: SimpleDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text("usuario es invalido"),
          ],
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: SizedBox(width: 350.0, child: Text(error)),
          ),
          SimpleDialogOption(
            child: FlatButton(
              color: Colors.blueAccent,
              onPressed: () => Navigator.of(context).popAndPushNamed("/login"),
              child: Text("Aceptar"),
            ),
          ),
        ],
      ));
}
