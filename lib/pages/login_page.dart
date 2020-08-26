import 'package:flutter/material.dart';
import 'package:web_app/widgets/customAlert_widget.dart';
import 'package:web_app/widgets/customTextLink_widget.dart';

class LoginPage extends StatelessWidget {
  final _emailController = new TextEditingController();
  final _passController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Center(
        child: SizedBox(
            height: 300.0,
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
                        Text("Welcome to WebApp",
                            style: (Theme.of(context).textTheme.headline6)),
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
                            CustomTextLink("Create Account", Colors.blue,
                                Colors.purple, () {}),
                            Spacer(),
                            FlatButton(
                              onPressed: () async {
                                _formKey.currentState.validate();
                                if (_formKey.currentState.validate()) {
                                  print("Logging in.......");

                                  onAlertAutentication(
                                      context, "please wait...");

                                  final List<String> results = [];
                                  //     await Provider.of<Authentication>(
                                  //             context,
                                  //             listen: false)
                                  //         .loginWithErrorMessage(
                                  //             _usernameControler.text, _passController.text);

                                  print("resultado login: " +
                                      results[0] +
                                      "  userID: " +
                                      results[1]);

                                  if (results[0] == "success") {
                                    // await Navigator.of(context)
                                    //     .pushNamed("/settings");
                                  } else
                                    onErrorAuth(context, results[0]);
                                }
                              },
                              color: Theme.of(context).primaryColor,
                              child: Text("login"),
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
