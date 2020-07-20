import 'package:flutter/material.dart';

class schemebutton extends StatelessWidget {
  schemebutton({this.title, @required this.onPressed});
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.grey,
      minWidth: 300,
      child: RaisedButton(
        highlightColor: Colors.blueGrey,
        onPressed: onPressed,
        child: Text(
          title,
        )
      ),
    );
  }
}

