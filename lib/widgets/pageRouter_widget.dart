import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/firebase/firestore_service.dart';
import 'package:web_app/models/user_model.dart';
import 'package:web_app/pages/home_page.dart';
import 'package:web_app/pages/login_page.dart';
import 'package:web_app/pages/register_page.dart';
import 'package:web_app/pages/unknown_page.dart';
import 'package:web_app/widgets/customTextLink_widget.dart';

class PageRouter extends StatelessWidget {
  final String parseRoute;

  PageRouter(this.parseRoute);

  @override
  Widget build(BuildContext context) {
    String userID = Provider.of<User>(context, listen: false).getCurrentUser();
    print("Routing userID = " + userID);

    //validate mobile screens
    final screenSize = MediaQuery.of(context).size.width;
    if (screenSize < 768) return mobileAlert;
    //crash error
    if (parseRoute == null) return LoginPage();

    if (parseRoute == "/") {
      return LoginPage();
    } else if (parseRoute == "/register") {
      return RegisterPage();
      //check user ID to proceed homepage && userID != "Empty"
    } else if (parseRoute == "/home" && userID != "Empty") {
      //cometi el error de hacerlo staless y ahora cada rebuild
      //jala toda la vista y la reconstruye
      final listenStream =
          Provider.of<Firestore>(context, listen: true).fetchStreamData();
      return HomePage(
        listenStream: listenStream,
      );
    }

    //default unknown page
    else {
      return Unknowpage(routname: parseRoute);
    }
  }
}

final mobileAlert = Material(
  child: Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This app only works on full screen"),
          Text("for mobile devices download it"),
          CustomTextLink("here", Colors.blue, Colors.purple, () {}),
        ],
      ),
    ),
  ),
);
