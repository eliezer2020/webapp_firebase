import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/firebase/authentication_service.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/models/user_model.dart';
import 'package:web_app/widgets/customAlert_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = new TextEditingController();

  final _passController = new TextEditingController();

  final _emailController = new TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Center(
        child: SizedBox(
            height: 370.0,
            width: 280.0,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Sign in",
                            style: (Theme.of(context).textTheme.headline6)),
                        TextFormField(
                          controller: _usernameController,

                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.blue,
                              ),
                              labelText: "username",
                              hintText: ""),
                          autovalidate: false,

                          //muestra si no hay texto
                          validator: (String value) {
                            return (value.isEmpty) ? " enter username" : null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: "email",
                              hintText: " example@email.com"),
                          autovalidate: false,
                          //muestra si no hay texto
                          validator: (String value) {
                            return (!value.contains("@"))
                                ? " enter valid email "
                                : null;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passController,
                          decoration: InputDecoration(
                            labelText: "password",
                            //hintText: "myPass ",
                          ),
                          autovalidate: false,
                          //muestra si no hay texto
                          validator: (String value) {
                            return (value.isEmpty) ? " ... " : null;
                          },
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            //Colors.blue[800]

                            Spacer(),
                            FlatButton(
                              onPressed: () async {
                                _formKey.currentState.validate();
                                if (_formKey.currentState.validate()) {
                                  print(_usernameController.text +
                                      _emailController.text +
                                      _passController.text);
                                  onAlertWait(context, "please wait...");

                                  //userLogin AUTH-FIREBASE
                                  final List<dynamic> results =
                                      await Provider.of<Authentication>(context,
                                              listen: false)
                                          .newUserWithErrorMessage(
                                              _usernameController.text,
                                              _emailController.text,
                                              _passController.text);

                                  if (results[0] == "success") {
                                    //set Single User Object
                                    Provider.of<User>(context, listen: false)
                                        .setFromMap(results[1]);
                                    //set username first because DB requieres it
                                    Provider.of<User>(context, listen: false)
                                        .setUsername(_usernameController.text);
                                    //make user PATH
                                    await Provider.of<Firestore>(context,
                                            listen: false)
                                        .makeUserDB();

                                    Navigator.of(context).pushNamed("/home");
                                  } else
                                    onErrorAuth(context, results[0]);
                                }
                              },
                              color: Theme.of(context).primaryColor,
                              child: Text("Register"),
                              hoverColor: Colors.blue[300],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
