//conlifct with user so namespacing
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:web_app/models/user_model.dart';

class Authentication {
  final authInstance = fb.FirebaseAuth.instance;
  String resultMessage;
  fb.UserCredential userCredential;

  fb.User newUser;
  //this function return user credection
  //user is inside result
  Future<List<dynamic>> newUserWithErrorMessage(
      String _username, String _email, String _pass) async {
    userCredential = await authInstance
        .createUserWithEmailAndPassword(email: _email, password: _pass)
        .then((result) {
      print("creating user  id " + result.user.uid);
      resultMessage = "success";
      newUser = result.user;
    }).catchError((e) {
      print(e.message);
      resultMessage = e.message;
      newUser = null;
    });
    //it is necesary otherwise it will broke my program
    //if the function return something different
    //dart transcompiller got confused with  return [resultMessage, {}}];
    //displayname not working with email

    return [resultMessage, userToMap(newUser)];
  }

// FirebaseAuthException:
//      this.message,
//       this.code,
//       this.email,
//       this.credential,
//display name not working
  Future<List<dynamic>> loginWithErrorMessage(
      String _email, String _pass) async {
    userCredential = await authInstance
        .signInWithEmailAndPassword(email: _email, password: _pass)
        .then((result) {
      newUser = result.user;
      resultMessage = "success";
    }).catchError((e) {
      print("exepcion login:" + e.message);
      resultMessage = e.message;
    });

    return [resultMessage, userToMap(newUser)];
  }

  Map<String, dynamic> userToMap(fb.User user) {
    if (user == null) return {};
    print("user to map  " + user.uid);

    return {
      "userID": user.uid,
      "username": user.displayName,
      "email": user.email,
    };
  }

  singOut() async {
    // newUser = null; bqd idea
    await authInstance.signOut().then((value) => null).catchError(print);
  }
}
