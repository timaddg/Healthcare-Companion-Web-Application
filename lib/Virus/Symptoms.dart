import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SymptomsPage extends StatefulWidget {
  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffd1d0cd),
              Color(0xffd1d0cd)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
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
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'SYMPTOMS',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '         COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization.',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Most common symptoms:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '>Fever\n>Dry cough\n>Tiredness',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Less common symptoms:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '>Aches and pains\n>Sore throat\n>Diarrhoea\n>Conjunctivitis\n>Headache\n>Loss of taste or smell\n>A rash on skin, or discolouration of fingers or toes',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Serious symptoms:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '>Difficulty breathing or shortness of breath\n>Chest pain or pressure\n>Loss of speech or movement\n',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
