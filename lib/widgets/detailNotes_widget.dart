import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/controllers/noteController_controller.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/models/note_model.dart';

Widget detailNotes(BuildContext context) {
  return Container(
    child: Card(
      child: Column(
        children: [
          Container(
            color: Colors.yellow[100],
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Detail Notes"),
                FloatingActionButton(
                  heroTag: "tag1",
                  elevation: 2,
                  hoverColor: Colors.blue[200],
                  backgroundColor: Colors.transparent,
                  mini: true,
                  onPressed: () {
                    Provider.of<NoteController>(context, listen: false)
                        .enableEditing();
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue[400],
                  ),
                ),
                FloatingActionButton(
                  heroTag: "tag2",
                  elevation: 2,
                  hoverColor: Colors.blue[200],
                  backgroundColor: Colors.transparent,
                  mini: true,
                  onPressed: () {
                    // Note selectedNote =
                    //     Provider.of<NoteController>(context).getSelectedNote();
                    // print(selectedNote.title);
                    // Provider.of<Firestore>(context, listen: false)
                    //     .firestoreUPDATE(selectedNote);
                  },
                  child: Icon(
                    Icons.save,
                    color: Colors.blue[400],
                  ),
                ),
                FloatingActionButton(
                  //necessary when multiple floatbotons
                  heroTag: "tag3",
                  elevation: 2,
                  hoverColor: Colors.red[200],
                  backgroundColor: Colors.transparent,
                  mini: true,
                  onPressed: () {},
                  child: Icon(
                    Icons.delete,
                    color: Colors.red[400],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(25),
                child: TextField(
                  controller: Provider.of<NoteController>(context, listen: true)
                      .myController,
                  enabled: Provider.of<NoteController>(context, listen: true)
                      .editing,
                )),
          )
        ],
      ),
      elevation: 8,
      color: Colors.yellow[50],
    ),
  );
}
