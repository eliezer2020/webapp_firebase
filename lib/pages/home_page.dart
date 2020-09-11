import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/controllers/noteController_controller.dart';
import 'package:web_app/firebase/authentication_service.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/models/note_model.dart';

import 'package:web_app/models/user_model.dart';
import 'package:web_app/widgets/customAlert_widget.dart';
import 'package:web_app/widgets/detailNotes_widget.dart';
import 'package:web_app/widgets/MenuNotes_widget.dart';

class HomePage extends StatelessWidget {
  final listenStream;

  const HomePage({Key key, this.listenStream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("building home page");
    //meti la pata enseñar en mi curso
    // final listenStream =
    //   Provider.of<Firestore>(context, listen: true).fetchStreamData();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _customApbbar(context),
        body: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: menuNotes(context, listenStream),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      //color: Colors.red,
                      )),
              Expanded(
                flex: 5,
                child: detailNotes(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _customApbbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      //deshanilitar back leading button
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(
            Icons.person,
            color: Colors.blueAccent,
          ),
        ),
        Center(
            child: Text(
          Provider.of<User>(context, listen: false).username,
          style: TextStyle(color: Colors.black),
        )),

        Spacer(),
        //equals to flatbutton.icon
        Container(
          width: 20.0,
        ),
        Center(
            child: Text(
          "logout",
          style: TextStyle(color: Colors.blueAccent),
        )),
        IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.blueAccent,
            ),
            onPressed: () async {
              Provider.of<Authentication>(context, listen: false).singOut();
              Provider.of<User>(context, listen: false).clearUser();
              Provider.of<NoteController>(context, listen: false)
                  .disposeNoteController();
              Navigator.of(context).pushNamed("/");
            })
      ],
    );
  }
}
