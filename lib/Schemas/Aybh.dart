import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'gov2.dart';

class AybhPage extends StatefulWidget {
  @override
  _AybhPageState createState() => _AybhPageState();
}

class _AybhPageState extends State<AybhPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar( backgroundColor: Color(0xFFB22222),
          title: Text("Ayushman Bharath Scheme"),

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,10),
                  child: Image.asset("images/ayush.jpeg"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text("Benefits covered under various Government-funded health insurance schemes in India have always been structured on an upper ceiling limit ranging from an annual cover of INR30,000 to INR3,00,000 per family across various States which created a fragmented system.\n\n->Medical examination, treatment and consultation\n->Pre-hospitalization\n->Medicine and medical consumables\n->Non-intensive and intensive care services\n->Diagnostic and laboratory investigations\n->Medical implantation services (where necessary)\n->Accommodation benefits\n->Food services\n->Complications arising during treatment\n->Post-hospitalization follow-up care up to 15 days\n",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

