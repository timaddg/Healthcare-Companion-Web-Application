import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/healthpage.dart';
import 'constants.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String bloodVal;
String name, height, weight, age;

class DetailsM extends StatefulWidget {
  static String id = 'detailsM';

  @override
  _DetailsMState createState() => _DetailsMState();
}

class _DetailsMState extends State<DetailsM> {
  Duration agec;
  DateTime dateTimeNow = DateTime.now();
  DateTime _dateTime;
  String ddmmyydate;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFB22222),
        title: Text(
          'Edit Details',
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFc6e2ff),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('images/jenjawin190400208.jpg'),
                        radius: 40,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (val) {
                    name = val;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (val) {
                    height = val;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your height in cms',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (val) {
                    weight = val;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your weight in kgs',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFc6e2ff),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _dateTime == null ? 'Date Of Birth' : ddmmyydate,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RaisedButton(
                        child: Text('Pick a date'),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate:
                                _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(1940),
                            lastDate: DateTime(2021),
                          ).then(
                            (date) {
                              setState(
                                () {
                                  _dateTime = date;
                                  ddmmyydate = _dateTime.day.toString() +
                                      "-" +
                                      _dateTime.month.toString() +
                                      "-" +
                                      _dateTime.year.toString();
                                  agec = dateTimeNow.difference(_dateTime);
                                  age = (agec.inDays / 365).floor().toString();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _firestore.collection('details').add({
                        'sender': loggedInUser.email,
                        'name': name,
                        'gender': 'Male',
                        'height': height,
                        'weight': weight,
                        'dob': ddmmyydate,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthPage(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Submit',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
