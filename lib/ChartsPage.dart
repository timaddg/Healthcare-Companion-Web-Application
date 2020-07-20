import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'Virus/Prevention.dart';
import 'Virus/Symptoms.dart';
import 'Pandemics/ebola.dart';
import 'Pandemics/aids.dart';
import 'Pandemics/swine.dart';
import 'Pandemics/blackdeath.dart';
import 'Pandemics/flu.dart';
import 'package:health_app/schemebutton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Virus/VirusPage.dart';

class ChartsHomePage extends StatefulWidget {
  final Widget child;

  ChartsHomePage({Key key, this.child}) : super(key: key);

  _ChartsHomePageState createState() => _ChartsHomePageState();
}

class _ChartsHomePageState extends State<ChartsHomePage> {
  final controller = ScrollController();
  double offset = 0;

  List<charts.Series<Death, String>> _seriesPieData;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  _generateData() {
    var piedata = [
      new Death('Injuries', 7.98, Color(0xff3366cc)),
      new Death('Cancer', 15.24, Color(0xff990099)),
      new Death('HIV', 3.43, Color(0xff109618)),
      new Death('CardioVascular Diseases', 33.41, Color(0xfffdbe19)),
      new Death('Chronic Respiratory Diseases', 8.32, Colors.black87),
      new Death('Other Non-Communicable Diseases', 15.44, Color(0xffdc3912)),
      new Death('Other Communicable Diseases', 16.19, Color(0xffff9900)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Death task, _) => task.name,
        measureFn: (Death task, _) => task.percentage,
        colorFn: (Death task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Deaths',
        data: piedata,
        labelAccessorFn: (Death row, _) => '${row.percentage}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Death, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.disease)),
                Tab(icon: Icon(FontAwesomeIcons.info)),
              ],
            ),
            title: Text('Disease Hub'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'WorldWide causes of Deaths Estimation',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(_seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification:
                                  charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxRows: 7,
                                  cellPadding: new EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  entryTextStyle: charts.TextStyleSpec(
                                      color: charts
                                          .MaterialPalette.purple.shadeDefault,
                                      fontFamily: 'Georgia',
                                      fontSize: 12),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                        charts.ArcLabelPosition.inside)
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ClipPath(
                            clipper: MyClipper(),
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.center,
                                      colors: [
                                        Color(0xff77c1c4),
                                        Color(0xff11249f),
                                      ])),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Stack(
                                      children: <Widget>[
                                        Image(
                                          image:
                                          AssetImage('images/drcorona.jpg'),
                                          width: 230,
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(),
                                        Positioned(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  8, 13, 8, 8),
                                              child: Text(
                                                'S\nT\nA\nY\n \nH\nO\nM\nE',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                              child: RaisedButton(
                                child: Text(
                                  'Symptoms',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SymptomsPage(),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                              child: RaisedButton(
                                child: Text(
                                  'Click Here for Preventative Measures',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Preventions(),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.brightness_1,
                                      color: Color(0xff2550a1),
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      color: Color(0xff2f69cb),
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      color: Color(0xff5187ed),
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      color: Color(0xff92b5f3),
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      color: Color(0xff86a7e1),
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffd5e3fa),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      '<- Intensity Scale ->',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Image(
                              image: AssetImage('images/covidinfo.png'),
                              height: 350,
                              width: 350,
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VirusPage(),
                                    ),
                                  );
                                });
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
                                child: Icon(
                                  Icons.graphic_eq,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
                            child: Text(
                              'Click the button for Corona Virus fatality rates',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'NOTABLE CASES',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                '    Boris Johnson, the Prime Minister of the United Kingdom tested positive for the corona virus',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: Image.asset("images/boris.jpg"),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                '   Boris was taken into the ICU but was discharged after two weeks.',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Image.asset("images/tom.webp"),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Text(
                                '     Actor Tom Hanks and his wife Rita Wilson, tested positive for the virus when they were in Australia in February 2020. They spent a week in isolation at a hospital in Queensland. After their discharge from the medical facility, the couple continued to self-quarantined at a rented home.',
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
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Major disease outbreaks in recent times',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              schemebutton(
                                title: 'EBOLA Virus Outbreak',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EbolaPage(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              schemebutton(
                                title: 'SWINE FLU Outbreak',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SwineFLuPage(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              schemebutton(
                                title: 'HIV AIDS',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AidsPage(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              schemebutton(
                                title: 'THE BLACK DEATH',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlackDeathPage(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              schemebutton(
                                title: '1918 SPANISH INFLUENZA',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FluPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              child: Text(
                                '   Around 25 to 75 million people died because of Pandemics in Eurasia. Throughout history, there have been a number of pandemics of diseases such as smallpox and tuberculosis. One of the most devastating pandemics was the Black Death (also known as The Plague), which killed an estimated 75–200 million people in the 14th century. Other notable pandemics include the 1918 influenza pandemic (Spanish flu) and the 2009 influenza pandemic (H1N1). Current pandemics include HIV/AIDS and the COVID-19 pandemic.',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

class MyClipper extends CustomClipper<Path> {
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
    return null;
  }
}

class Death {
  String name;
  double percentage;
  Color colorval;
  Death(this.name, this.percentage, this.colorval);
}