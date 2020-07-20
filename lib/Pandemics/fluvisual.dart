import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FluVisual extends StatefulWidget {
  @override
  _FluVisualState createState() => _FluVisualState();
}

class _FluVisualState extends State<FluVisual> {
  final controller = ScrollController();
  double offset = 0;

  void initState() {
    super.initState();
    _fludata = List<charts.Series<Flu, String>>();
    _generateflu();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  List<charts.Series<Flu, String>> _fludata;
  _generateflu() {
    var data1 = [
      new Flu('Japan', 390000),
      new Flu('Usa', 800000),
      new Flu('Ghana', 120000),
      new Flu('Brazil', 300000),
      new Flu('Britain', 350000),
      new Flu('France (+)', 450000)
    ];
    _fludata.add(
      charts.Series(
        domainFn: (Flu fl, _) => fl.place,
        measureFn: (Flu fl, _) => fl.quantity,
        id: '2019',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Flu fl, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff964b00)),
      ),
    );
  }

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
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  '1918 SPANISH INFLUENZA',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _fludata,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    //behaviors: [new charts.SeriesLegend()],
                    animationDuration: Duration(seconds: 5),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '   The Spanish flu was the first of two pandemics caused by the H1N1 influenza virus; the second was the swine flu in 2009. As many as 50 million people died from the virus, though the true figure is thought to be even higher',
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
    );
  }
}

class Flu {
  String place;
  int quantity;
  Flu(this.place, this.quantity);
}
