import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _symptoms;
  String _cond;
  String _allergy;
  String _tim;
  String _med;
  String _age;
  final _auth=FirebaseAuth.instance;
  final _firestore =Firestore.instance;
  FirebaseUser loggedInUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  createAlertDialog(BuildContext context) {
    TextEditingController mycontroller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'WE PROVIDE ONLY THE CONTACT NUMBER OF  ER \n EMERGENCIES ARE TREATED AT THE HOSPITAL ONLY  ',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          );
        });
  }
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

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'NAME',
          labelStyle: TextStyle(fontStyle: FontStyle.normal)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }
  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'AGE ',
          labelStyle: TextStyle(fontStyle: FontStyle.normal)),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Age is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _age = value;
      },
    );
  }

  Widget _buildSymptoms() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'SYMPTOMS/INJURY',
          labelStyle: TextStyle(fontStyle: FontStyle.normal)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'SYMPTOMS is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _symptoms = value;
      },
    );
  }

  Widget _buildCondition() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'KNOWN CONDITION(eg:High BP,diabetic)',
          ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'this field is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _cond = value;
      },
    );
  }

  Widget _buildAllergies() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'ANY KNOWN ALLERGIES',
          ),
      validator: (String value) {
        if (value.isEmpty) {
          return ' this field is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _allergy = value;
      },
    );
  }

  Widget _buildMedication() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'ANY ACTIVE MEDICATIONS ',
         )
        ,validator: (String value) {
        if (value.isEmpty) {
          return 'this field is required';
        }

        return null;
      },
      onSaved: (String value) {
        _med = value;
      },
    );
  }

  Widget _buildTime() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'TIME ',
          labelStyle: TextStyle(fontStyle: FontStyle.normal)),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'this field  is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _tim = value;
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
        title: Text("EMERGENCY RAPID FORM"),
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
                  _buildName(),
                  _buildAge(),
                  _buildSymptoms(),
                  _buildCondition(),
                  _buildAllergies(),
                  _buildMedication(),
                  _buildTime(),
                  SizedBox(height: 0.1),
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
                      print(_name);
                      print(_age);
                      print(_symptoms);
                      print(_cond);
                      print(_allergy);
                      print(_med);
                      print(_tim);
                      _firestore.collection('EMERGENCY').add({
                        'name':_name,
                        'age':_age,
                        'symptoms':_symptoms,
                        'condition':_cond,
                        'allergy':_allergy,
                        'medication':_med,
                        'time':_tim,
                        'sender':loggedInUser.email,
                      });
                      createAlertDialog(context);

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
