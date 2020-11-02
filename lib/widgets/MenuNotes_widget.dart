import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/controllers/noteController_controller.dart';
import 'package:web_app/firebase/firestore_service.dart';

import 'package:web_app/models/note_model.dart';
import 'package:web_app/utils/date_utils.dart';
import 'package:web_app/widgets/customAlert_widget.dart';

//Stream<List<Note>> listenStream)
Widget menuNotes(BuildContext context, Stream<List<Note>> listenStream) {
  //usar un mockup user me permite validar los widget sin necesidad de hace login
  return Card(
    elevation: 8,
    color: Colors.blue[50],
    child: Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.blue[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: "tag0",
                elevation: 2,
                hoverColor: Colors.blue[200],
                backgroundColor: Colors.transparent,
                onPressed: () {
                  var now = getCustomDate();
                  onCreateALert(context, now);
                },
                child: Icon(
                  Icons.add,
                ),
              ),
              Text("Menu notes"),
              SizedBox(
                width: 30.0,
              )
            ],
          ),
        ),
        //resize dinamically the single child
        Expanded(
            child: Container(
          //use Strong types on every function otherwise JS get confused
          child: StreamBuilder<List<Note>>(
            stream: listenStream,
            initialData: [],
            builder: (context, snapshot) {
              //no data yet
              if (snapshot.data.length == 0) {
                return //Center(child: CircularProgressIndicator());
                    Container(
                  child: ListTile(
                    onTap: null,
                    leading: Icon(
                      Icons.file_copy,
                      color: Colors.blueGrey,
                    ),
                    title: Text("no data..."),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Scrollbar(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) => ListfromNote(
                            note: snapshot.data[i],
                          )),
                );
              }
            },
          ),
        )),
        crearFooter(),
      ],
    ),
  );
}

Container crearFooter() {
  return Container(
      color: Colors.blueGrey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.blueGrey[400],
          ),
          Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.blueGrey[400],
          ),
        ],
      ));
}

class ListfromNote extends StatelessWidget {
  final Note note;

  const ListfromNote({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(note.title),
        onTap: () {
          Provider.of<NoteController>(context, listen: false)
              .setSelectedNote(note);
        },
        leading: Icon(
          Icons.file_copy,
          color: Colors.blueGrey,
        ));
  }
}
