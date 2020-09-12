import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/firebase/authentication_service.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/models/user_model.dart';
import 'package:web_app/widgets/customAlert_widget.dart';
import 'package:web_app/widgets/customTextLink_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //formkey is affecting whenever i want to get back
  //so we need to clean the global key
  @override
  void dispose() {
    //_formKey.currentState.dispose();
    super.dispose();
  }

  final _emailController = new TextEditingController();

  final _passController = new TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //its neesary to disable user back button to prevent see old user info
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                              CustomTextLink(
                                  "Create Account", Colors.blue, Colors.purple,
                                  () {
                                Navigator.of(context).pushNamed("/register");
                              }),
                              Spacer(),
                              FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text("login"),
                                  hoverColor: Colors.blue[300],
                                  onPressed: () async {
                                    _formKey.currentState.validate();
                                    if (_formKey.currentState.validate()) {
                                      onAlertWait(context, "please wait...");
                                      print("onCLick Logging in.......");
                                      final List<dynamic> results =
                                          await Provider.of<Authentication>(
                                                  context,
                                                  listen: false)
                                              .loginWithErrorMessage(
                                                  _emailController.text,
                                                  _passController.text);

                                      if (results[0] == "success") {
                                        //set Single User Object
                                        Provider.of<User>(context,
                                                listen: false)
                                            .setFromMap(results[1]);
                                        print(results[1]);

                                        //no se usa makeuser DB porque ya se hizo en
                                        //la creacion
                                        //make user PATH
                                        Provider.of<Firestore>(context,
                                                listen: false)
                                            .initUserPath();

                                        String userName =
                                            await Provider.of<Firestore>(
                                                    context,
                                                    listen: false)
                                                .getFirebaseUsername();
                                        Provider.of<User>(context,
                                                listen: false)
                                            .setUsername(userName);

                                        Navigator.of(context)
                                            .pushNamed("/home");
                                      } else {
                                        onErrorAuth(context, results[0]);
                                      }
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
