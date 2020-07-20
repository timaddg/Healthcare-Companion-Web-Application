import 'package:flutter/material.dart';
import 'plaguevisual.dart';

class BlackDeathPage extends StatefulWidget {
  @override
  _BlackDeathPageState createState() => _BlackDeathPageState();
}

class _BlackDeathPageState extends State<BlackDeathPage> {
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
          title: Text('Black Death'),
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
                    'The Black Death',
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
                  child: Image.asset("images/bd.jpg"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '   The Black Death, also known as the Pestilence and the Plague, was the most fatal pandemic recorded in human history, resulting in the deaths of up to 75–200 million people in Eurasia and North Africa, peaking in Europe from 1347 to 1351. Plague, the disease caused by the bacterium Yersinia pestis, is believed to have been the cause.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlagueVisual(),
                      ),
                    );
                  });
                },
                child: Icon(
                  Icons.graphic_eq,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    ' Y.pestis infection can cause septicaemic and pneumonic plagues but most commonly results in bubonic plague. The Black Death was the second plague pandemic recorded, after the Plague of Justinian. The plague created religious, social, and economic upheavals, with profound effects on the course of European history.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
