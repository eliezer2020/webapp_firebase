import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/models/user_model.dart';
import 'package:web_app/pages/home_page.dart';
import 'package:web_app/pages/login_page.dart';
import 'package:web_app/pages/register_page.dart';
import 'package:web_app/pages/unknown_page.dart';

class PageRouter extends StatelessWidget {
  final String parseRoute;

  PageRouter(this.parseRoute);

  @override
  Widget build(BuildContext context) {
    String userID = Provider.of<User>(context, listen: false).getCurrentUser();
    print("Routing userID = " + userID);

    if (parseRoute == "/") {
      return LoginPage();
    } else if (parseRoute == "/register") {
      return RegisterPage();
      //check user ID to proceed homepage && userID != "Empty"
    } else if (parseRoute == "/home" && userID != "Empty") {
      return HomePage();
    }

    //default unknown page
    else {
      return Unknowpage(routname: parseRoute);
    }
  }
}
