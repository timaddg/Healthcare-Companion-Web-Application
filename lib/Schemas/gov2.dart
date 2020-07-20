import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/schemebutton.dart';
import 'Cghs.dart';
import 'Pmssy.dart';
import 'Uim.dart';
import 'Aybh.dart';

class Govt2Page extends StatefulWidget {
  @override
  _Govt2PageState createState() => _Govt2PageState();
}

class _Govt2PageState extends State<Govt2Page> {
  createAlertDialog(BuildContext context) {
    TextEditingController mycontroller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Any Questions?'),
            content: TextField(
              controller: mycontroller,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 3.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(mycontroller.text.toString());
                },
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Color(0xFFB22222),
        title: Text("Prominent Schemes"),
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
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[


                Container(
                 height: 300,
                 width: 300,
                 child: Image(image:AssetImage('images/logo.png')),
               ),

              schemebutton(
                title: "Central Government Health Scheme",
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CghsPage(),
                      ),
                    );
                  });
                },
              ),
              SizedBox(
                height: 6,
              ),
              schemebutton(
                title: " Pradhan Mantri Swasthya Suraksha Yojana",
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PmsyPage(),
                      ),
                    );
                  });
                },
              ),
              SizedBox(
                height: 6,
              ),
              schemebutton(
                title: "Universal Immunization Program",
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UiPage(),
                      ),
                    );
                  });
                },
              ),
              SizedBox(
                height: 6,
              ),
              schemebutton(
                title: "Ayushman Bharath Scheme",
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AybhPage(),
                      ),
                    );
                  });
                },
              ),
              SizedBox(
                height: 6,
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.help), backgroundColor: Color(0xFFB22222),
        onPressed: () {
          createAlertDialog(context);
        },
      ),
    );
  }
}