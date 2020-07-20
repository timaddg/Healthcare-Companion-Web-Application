import 'package:flutter/material.dart';

class Preventions extends StatefulWidget {
  @override
  _PreventionsState createState() => _PreventionsState();
}

class _PreventionsState extends State<Preventions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB22222),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xffcfffc2), Color(0xffd1d0cd)],
          begin: Alignment.center,
        )),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffd1d0cd),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('images/prev.png'),
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'To prevent the spread of COVID-19:\n\n>Clean your hands often. Use soap and water, or an alcohol-based hand rub.\n>Maintain a safe distance from anyone who is coughing or sneezing.\n>Don’t touch your eyes, nose or mouth.\n>Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.\n>Stay home if you feel unwell.\n>If you have a fever, cough and difficulty breathing, seek medical attention. Call in advance.\n>Follow the directions of your local health authority.',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'RobotoMono'
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
