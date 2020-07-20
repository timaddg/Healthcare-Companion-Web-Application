import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_app/UserDetails/detailsF.dart';

import 'detailsM.dart';
import 'image.dart';

import 'detailsF.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      home: UserDetails(),
      routes: {
        UserDetails.id: (context) => UserDetails(),
        DetailsF.id: (context) => DetailsF(),
        DetailsM.id: (context) => DetailsM(),
        PhotoApp.id: (context) => PhotoApp(),

      },
    );
  }
}

class UserDetails extends StatefulWidget {
  static String id = 'user';

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _auth = FirebaseAuth.instance;

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
          'User Details',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('details').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('loading');
          }
          final messages = snapshot.data.documents;
          List<Text> msgwidgets = [];
          for (var det in messages) {
            final send = det.data['sender'];
            final name = det.data['name'];
            final ht = det.data['height'];
            final wt = det.data['weight'];
            final sx = det.data['gender'];
            final curr = loggedInUser.email;

            if (curr == send) {
              return Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(width:800.0,
                        color: Colors.white70,
                        child: Text(
                          ' Email: $send',
                          style: new TextStyle(fontSize: 22.0),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width:800.0,
                        color:Color(0xFFD4DCE7),
                        child: Text(
                          ' Name: $name',
                          style: new TextStyle(fontSize: 28.0),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(width:700.0,
                        color: Color(0xFFD4DCE7),
                        child: Text(
                          ' Sex: $sx',
                          style: new TextStyle(fontSize: 28.0),
                        )),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(width:900.0,
                        color: Color(0xFFD4DCE7),
                        child: Text(
                          ' Height: $ht',
                          style: new TextStyle(fontSize: 28.0),
                        )),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(width:700.0,
                        color: Color(0xFFD4DCE7),
                        child: Text(
                          ' Weight: $wt',
                          style: new TextStyle(fontSize: 28.0),
                        )),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 300,
                      width: 800,
                      child: Image(image:AssetImage('images/logo.png')),
                    ),
                  ],
                ),
              );
            }
          }

          return Column(
            children: <Widget>[
              Text(
                snapshot.data.documents[0]['name'],
                style: new TextStyle(fontSize: 40.0),
              ),
              Text(snapshot.data.documents[0]['sender'],
                  style: new TextStyle(fontSize: 40.0)),
            ],
          );
        },
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({
    @required this.text,
    this.value,
  });
  final String text, value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.all(10),
      width: 900,
      height: 50,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFcae1ff),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
