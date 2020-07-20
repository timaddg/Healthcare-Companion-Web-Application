import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AidsVisual extends StatefulWidget {
  @override
  _AidsVisualState createState() => _AidsVisualState();
}

class _AidsVisualState extends State<AidsVisual> {
  final controller = ScrollController();
  double offset = 0;

  void initState() {
    super.initState();
    _aidsdata = List<charts.Series<Aids, String>>();
    _generateaids();
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

  List<charts.Series<Aids, String>> _aidsdata;
  _generateaids() {
    var deaths = [
      new Aids('United States', 1018000),
      new Aids('India', 2170000),
      new Aids('Russia', 1000000),
      new Aids('Nigeria', 3200000),
      new Aids('Kenya', 1600000),
      new Aids('Mozambique', 1800000)
    ];

    _aidsdata.add(
      charts.Series(
        domainFn: (Aids hiv, _) => hiv.place,
        measureFn: (Aids hiv, _) => hiv.quantity,
        id: '2017',
        data: deaths,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Aids pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
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
          title: Text('Aids'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'HIV AIDS Cases Estimation',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _aidsdata,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    //behaviors: [new charts.SeriesLegend()],
                    animationDuration: Duration(seconds: 5),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '     As of 2018, 37.9 million people are estimated infected with HIV globally.',
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '     South Africa has the largest number of cases till date with over 7 million',
                            style: TextStyle(
                              fontSize: 23,
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
      ),
    );
  }
}

class Aids {
  String place;
  int quantity;
  Aids(this.place, this.quantity);
}
