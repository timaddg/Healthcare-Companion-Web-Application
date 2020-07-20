import 'package:flutter/material.dart';
import 'package:health_app/healthpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class BloodScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BloodScreenState();
  }
}

class BloodScreenState extends State<BloodScreen>{
  final _auth=FirebaseAuth.instance;
  final _firestore =Firestore.instance;
  FirebaseUser loggedInUser;
  String _type;
  String _emg;
@override
void initState(){
  super.initState();
  getCurrentUser();
}

void getCurrentUser() async{
  try {
    final user= await _auth.currentUser();
    if(user!=null){
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }
  catch (e){
    print(e);
  }
}


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  createAlertDialog(BuildContext context) {
    TextEditingController mycontroller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Return to home page',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          );
        });
  }
  Widget _buildType() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'BLOOD GROUP ',
          labelStyle: TextStyle(fontStyle: FontStyle.normal)),

      validator: (String value) {
        if (value.isEmpty) {
          return 'this field  is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _type = value;
      },
    );
  }
  Widget _buildEmergency() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'EMERGENCY DONOR ',
          labelStyle: TextStyle(fontStyle: FontStyle.normal)),

      validator: (String value) {
        if (value.isEmpty) {
          return 'this field  is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _emg = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        title: Text("BLOOD DONATION FORM"),
          backgroundColor: Color(0xFFB22222)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:0.0,horizontal:0.0),
          child: Container(
            margin: EdgeInsets.all(0.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildType(),
                  _buildEmergency(),

                  SizedBox(height: 2.0),
                  RaisedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      createAlertDialog(context);
                      print(_emg);
                      print(_type);
                      _firestore.collection('blood').add({
                        'blood_group':_type,
                        'sender':loggedInUser.email,
                        'emergency':_emg,
                      });

                      //Send to API
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




