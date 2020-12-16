import 'package:web_app/models/note_model.dart';
import 'package:web_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  User userObject;
  //main collection
  String path;
  //refresh uid calling userObject get uid
  //instead of using change notifier
  String uid;
  final firestoreInstance = FirebaseFirestore.instance;
  Firestore(this.userObject);

  //setUser path on BD
  //set created, add dont
  Future<void> makeUserDB() async {
    initUserPath();
    print("making DB");

    await firestoreInstance
        .doc(path)
        .set({"username": "${userObject.username}"}).catchError(print);
  }

  //get StreamSOcket from firebase
  //everytime we init firebase
  Stream<List<Note>> fetchStreamData() {
    initUserPath();

    print("getting firebase stream  from: " + path);

    return firestoreInstance
        .collection(path + "/notes")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((item) => Note.fromDocs(item)).toList());
  }
  

  //use implementation of firebaseData
  firestoreCREATE(Note data) async {
    await firestoreInstance.collection(path + "/notes").add({
      "title": "${data.title}",
      "body": "${data.body}",
    }).then((result) {
      data.documentID = result.id;
      print("+1 added to firestore" + result.id);
    }).catchError(print);
  }

  firestoreDELETE(Note data) async {
    await firestoreInstance
        .collection(path + "/notes")
        .doc(data.documentID)
        .delete()
        .then((value) {
      print(data.title + "successfully deleted");
    }).catchError(print);
  }

  firestoreUPDATE(Note data) async {
    firestoreInstance
        .collection(path + "/notes")
        .doc(data.documentID)
        .update(data.toMap())
        .then((value) {
      print("${data.title} successfully updated");
    }).catchError(print);
  }

  //refresh user data and path
  void initUserPath() {
    this.uid = userObject.getCurrentUser();
    this.path = "users/$uid";
    print("making userpath  .." + path);
  }

  Future<String> getFirebaseUsername() async {
    String _userName;
    var userPath =
        firestoreInstance.collection("users").doc(this.userObject.userID);

    await userPath.get().then((doc) {
      final mappedDoc = doc.data();
      _userName = mappedDoc["username"];
      print("fetch username:" + _userName);
    }).catchError(print);

    return _userName;
  }
}
