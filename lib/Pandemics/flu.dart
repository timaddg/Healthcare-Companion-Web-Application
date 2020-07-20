import 'package:flutter/material.dart';
import 'fluvisual.dart';

class FluPage extends StatefulWidget {
  @override
  _FluPageState createState() => _FluPageState();
}

class _FluPageState extends State<FluPage> {
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
          title: Text('Spanish Influenza'),
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
                  child: Image.asset("images/spanish.jpg"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '   The Spanish flu, also known as the 1918 flu pandemic, was an unusually deadly influenza pandemic. Lasting from January 1918 to December 1920, it infected 500 million people – about a third of the population of the world at the time. The death toll is estimated to have been anywhere from 17 million to 50 million, and possibly as high as 100 million, making it one of the deadliest pandemics in human history.',
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
                        builder: (context) => FluVisual(),
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
                    '   This flu killed more people in 24 weeks than HIV/AIDS killed in 24 years. However, it killed a much lower percentage of the population than the Black Death, which lasted for many more yearsTo maintain morale, World War I censors minimized early reports of illness and mortality in Germany, the United Kingdom, France, and the United States. Newspapers were free to report the effects of the epidemic in neutral Spain, such as the grave illness of King Alfonso XIII, and these stories created a false impression of Spain as especially hard hit. This gave rise to the name Spanish flu. Historical and epidemiological data are inadequate to identify with certainty the geographic origin of the pandemic, with varying views as to its location.',
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
