import 'package:flutter/material.dart';
import 'swinenumber.dart';

class SwineFLuPage extends StatefulWidget {
  @override
  _SwineFLuPageState createState() => _SwineFLuPageState();
}

class _SwineFLuPageState extends State<SwineFLuPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFB22222),
          leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text('Swine Flu'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 18, 8, 8),
                  child: Text(
                    'SWINE FLU INFLUENZA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("images/swinflu.jpg"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '   Swine influenza is an infection caused by any one of several types of swine influenza viruses. Swine influenza virus or swine-origin influenza virus is any strain of the influenza family of viruses that is endemic in pigs. As of 2009, the known Swine influenza virus strains include influenza C and the subtypes of influenza A known as H1N1, H1N2, H2N1, H3N1, H3N2, and H2N3. This disease had a major outbreak in 2009',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SwineVisual(),
                      ),
                    );
                  });
                },
                child: Icon(
                  Icons.graphic_eq,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
