import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'healthpage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:health_app/RoundedButton.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  bool spinner = false;
  String email;
  String password;
  @override
  void initState() {
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
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                height: 9.0,
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
                height: 4.0,
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
                height: 10.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Color(0xFFB22222),
                onPressed: () async{
                  try{
                    spinner = true;
                    final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('email', loggedInUser.email);
                    if(user!=null){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => HealthPage()));
                    }


                  }
                  catch(e){
                    print(e);
                  }



                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
