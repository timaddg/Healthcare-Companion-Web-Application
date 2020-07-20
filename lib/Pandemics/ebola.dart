import 'package:flutter/material.dart';
import 'EbolaVisual.dart';

class EbolaPage extends StatefulWidget {
  @override
  _EbolaPageState createState() => _EbolaPageState();
}

class _EbolaPageState extends State<EbolaPage> {
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
          title: Text('Ebola'),
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
                    'EBOLA VIRUS outbreak in Africa',
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
                  child: Image.asset("images/ebola.jpg"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    ' Ebola virus disease (EVD), or simply Ebola, is a viral haemorrhagic fever of humans and other primates caused by ebolaviruses. Signs and symptoms typically start between two days and three weeks after contracting the virus with a fever, sore throat, muscular pain, and headaches. Vomiting, diarrhoea and rash usually follow, along with decreased function of the liver and kidneys. At this time, some people begin to bleed both internally and externally. ',
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
                        builder: (context) => EbolaVisual(),
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
                    '     The disease has a high risk of death, killing 25% to 90% of those infected, with an average of about 50%. This is often due to low blood pressure from fluid loss, and typically follows six to 16 days after symptoms appear. The virus spreads through direct contact with body fluids, such as blood from infected humans or other animals. Spread may also occur from contact with items recently contaminated with bodily fluids',
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
