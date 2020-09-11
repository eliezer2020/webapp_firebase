import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/controllers/noteController_controller.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/models/note_model.dart';

//tell user to wait
onAlertWait(BuildContext context, String text) {
  showDialog(
      context: context,
      child: SimpleDialog(
        title: Center(
          child: Column(
            children: [
              Text(text),
              Container(
                  width: 150.0,
                  height: 150.0,
                  child: Image.asset("assets/Loading_2.gif")),
            ],
          ),
        ),
      ));
}

//something wrong with auth service
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
              onPressed: () => Navigator.of(context).popAndPushNamed("/"),
              child: Text("Aceptar"),
            ),
          ),
        ],
      ));
}

onCreateALert(BuildContext context, String texto) {
  final titleController = TextEditingController();
  titleController.text = texto;
  showDialog(
      context: context,
      child: SimpleDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.file_copy,
              color: Colors.blueGrey,
            ),
            Center(child: Text("New Note")),
          ],
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: TextFormField(
              controller: titleController,

              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  labelText: "title",
                  hintText: ""),
              autovalidate: false,

              //muestra si no hay texto
              validator: (String value) {
                return (value.isEmpty) ? " enter username" : null;
              },
            ),
          ),
          SimpleDialogOption(
            child: FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                final newNote = Note(
                  title: titleController.text,
                  body: "..",
                );

                Provider.of<Firestore>(context, listen: false)
                    .firestoreCREATE(newNote);
                Provider.of<NoteController>(context, listen: false)
                    .setSelectedNote(newNote);
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ),
        ],
      ));
}

onDeleteALert(BuildContext context, String texto) {
  final titleController = TextEditingController();
  titleController.text = texto;
  showDialog(
      context: context,
      child: SimpleDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.file_copy,
              color: Colors.blueGrey,
            ),
            Center(child: Text(texto)),
          ],
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: FlatButton(
              color: Colors.blueAccent,
              onPressed: () async {
                Note selectedNote =
                    Provider.of<NoteController>(context, listen: false)
                        .getSelectedNote();

                await Provider.of<Firestore>(context, listen: false)
                    .firestoreDELETE(selectedNote);
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ),
        ],
      ));
}
