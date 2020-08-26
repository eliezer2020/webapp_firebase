import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTextLink extends StatefulWidget {
  CustomTextLink(this.label, this.defaultColor, this.hoverColor, this.callback);

  final String label;
  final Function callback;
  final Color hoverColor;
  final Color defaultColor;

  @override
  State<StatefulWidget> createState() => _CustomTextLinkState();
}

class _CustomTextLinkState extends State<CustomTextLink> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        //SystemMouseCursors.text
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          isHover = true;
          setState(() {});
        },
        onExit: (event) {
          isHover = false;
          setState(() {});
        },
        child: GestureDetector(
          onTap: super.widget.callback,
          child: Text(super.widget.label,
              style: TextStyle(
                fontWeight: (isHover) ? FontWeight.w600 : FontWeight.normal,
                color: (isHover)
                    ? super.widget.hoverColor
                    : super.widget.defaultColor,
                decoration: TextDecoration.underline,
              )),
        ));
  }
}

//Flatbutton hoverColor: Colors.transparent,
// onPressed: super.widget.callback,
// //color on pressed (optional)
// highlightColor: Colors.grey[100],
// //color Animation
// splashColor: Colors.transparent,
