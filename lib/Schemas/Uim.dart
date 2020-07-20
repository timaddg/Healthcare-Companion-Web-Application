import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'gov2.dart';

class UiPage extends StatefulWidget {
  @override
  _UiPageState createState() => _UiPageState();
}

class _UiPageState extends State<UiPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar( backgroundColor: Color(0xFFB22222),
          title: Text("UI PAGE"),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40,0,40,30),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset("images/UIP.png",
                      height: 400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text("Vaccines provided under UIP:\n\nBacillus Calmette-Guerin vaccine- It is given to infants to protect them from tubercular meningitis and disseminated TB.When to give – BCG vaccine is given at birth or as early as possible till 1year ofRoute and site- BCG is given as intradermal injection in left upper arm.\n\nOPV- Oral Polio Vaccine. It protects children from poliomylitis.When to give- OPV is given at birth called zero dose and three doses are given at 6, 10 and 14 weeks. A booster dose is given at 16-24 months of age.Route and site - OPV is given orally in the form of two drops.\n\nHepatitis B vaccine-Hepatitis B vaccine protects from Hepatitis B virus infection.When to give- Hepatitis B vaccine is given at birth or as early as possible within 24 hours. Subsequently 3 dose are given at 6, 10 and 14 weeks in combination with DPT and Hib in the form of pentavalent vaccine.Route and site- Intramuscular injection is given at anterolateral side of mid thigh.\n\nPentavalent Vaccine-Pentavalent vaccine is a combined vaccine to protect children from five diseases Diptheria, Tetanus, Pertusis, Haemophilis influenza type b infection and Hepatitis B.When to give - Three doses are given at 6, 10 and 14 weeks of age (can be given till one year of age).Route and site-Pentavalent vaccine is given intramuscularly on anterolateral side of mid thigh.\n\nRotavirus Vaccine-RVV stands for Rotavirus vaccine. It gives protection to infants and children against rotavirus diarrhoea. It is given in select states.When to give - Three doses of vaccine are given at 6, 10, 14 weeks of age.Route and site-5 drops of vaccine are given orally.\n\nALL THE ABOVE IMMUNIZATIONS CAN BE TAKEN AT OUR HOSPITALS",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ),
            ],
          ),
        ),
    );
  }
}

