import 'package:flutter/material.dart';
import 'RoundedButton.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_page';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showspinner = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB22222),
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
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      kTextDecoration.copyWith(hintText: 'Enter email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      kTextDecoration.copyWith(hintText: 'Enter password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Color(0xFFB22222),
                onPressed: () async {
                  setState(() {
                    showspinner = true;
                    Navigator.pushNamed(context, LoginScreen.id);
                   try{
                     final newUser= _auth.createUserWithEmailAndPassword(email: email, password: password);
                     if(newUser!=null){
                       Navigator.pushNamed(context, LoginScreen.id);
                     }
                   }
                   catch (e) {
                     print(e);
                   }

                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
