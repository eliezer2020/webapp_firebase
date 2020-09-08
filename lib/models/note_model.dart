import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String title;
  String body;

  String documentID;

  Note({this.title, this.body, this.documentID});

  //should be accesible by other classes withour the object
  //if i dont add Note JS return moderfucker null
  //very import user <T>function
  static Note fromDocs(DocumentSnapshot doc) {
    //verify adress
    if (!doc.exists) return null;

    //get map from firebase doc
    final docMapped = doc.data();

    return Note(
      title: docMapped["title"],
      body: docMapped["body"],
      documentID: doc.id,
    );
  }

  //convert to Map
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "body": body,
      "documentID": documentID,
    };
  }
}
