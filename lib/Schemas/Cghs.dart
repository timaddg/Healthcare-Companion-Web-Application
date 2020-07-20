import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'gov2.dart';

class CghsPage extends StatefulWidget {
  @override
  _CghsPageState createState() => _CghsPageState();
}

class _CghsPageState extends State<CghsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Color(0xFFB22222),
        title: Text("Central Government Health Scheme"),
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
              child: Image.asset("images/cghs.jpg"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
           Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text("The main components of the Scheme are: The dispensary services including domiciliary care F. W. & M.C.H. Services Specialists consultation facilities both at dispensary, polyclinic and hospitallevel including X-Ray, ECG and Laboratory Examinations.Hospitalization.Organization for the purchase, storage, distribution and supply of medicines and other requirementsHealth Education to beneficiaries.",
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




