import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/controllers/noteController_controller.dart';
import 'package:web_app/firebase/authentication_service.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/pages/home_page.dart';
import 'package:web_app/pages/login_page.dart';

import 'package:web_app/widgets/pageRouter_widget.dart';

import 'models/user_model.dart';

void main() {
  runApp(MyWebApp());
}

class MyWebApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //single User Provider
        Provider<User>(
          create: (context) => new User(),
        ),
        Provider<Authentication>(
          create: (context) => new Authentication(),
        ),

        //si no le pongo el tipo al provider
        // la dart Virtual Machine  arroja un error culero
        ProxyProvider<User, Firestore>(
          update: (_, user, __) => Firestore(user),
        ),
        ChangeNotifierProvider<NoteController>(
          create: (context2) => new NoteController(),
        )

        //authService
      ],
      child: MaterialApp(
          title: "myWebApp",
          home: LoginPage(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
                builder: (context) => PageRouter(settings.name));
          }),
    );
  }
}
