import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  IconWidget({this.icon, this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
