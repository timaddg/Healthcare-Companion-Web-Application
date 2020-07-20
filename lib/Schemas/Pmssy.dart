import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'gov2.dart';

class PmsyPage extends StatefulWidget {
  @override
  _PmsyPageState createState() => _PmsyPageState();
}
class _PmsyPageState extends State<PmsyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Color(0xFFB22222),
        title: Text("Pradhan Mantri Swasthya Suraksha Yojana"),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
          ),
          onTap: (){
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,10),
              child: Image.asset("images/pmssy.jpg"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                  "The Pradhan Mantri Swasthya Suraksha Yojana (PMSSY) was announced with objectives of correcting regional imbalances in the availability of affordable/ reliable tertiary healthcare services and also to augment facilities for quality medical education in the country by setting up of various institutions like AIIMS and upgrading government medical college institutions. ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

