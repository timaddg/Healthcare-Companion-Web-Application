import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class EbolaVisual extends StatefulWidget {
  @override
  _EbolaVisualState createState() => _EbolaVisualState();
}

class _EbolaVisualState extends State<EbolaVisual> {
  final controller = ScrollController();
  double offset = 0;

  void initState() {
    super.initState();
    _eboladata = List<charts.Series<Ebola, String>>();
    _generateebola();
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

  List<charts.Series<Ebola, String>> _eboladata;
  _generateebola() {
    var data1 = [
      new Ebola('Guinea', 3358),
      new Ebola('Liberia', 3163),
      new Ebola('Sierra Leone', 8706),
    ];
    _eboladata.add(
      charts.Series(
        domainFn: (Ebola eb, _) => eb.place,
        measureFn: (Ebola eb, _) => eb.quantity,
        id: '2019',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Ebola eb, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff8B0000)),
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
          title: Text('Ebola'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  '21st Century Ebola Data',
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _eboladata,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    //behaviors: [new charts.SeriesLegend()],
                    animationDuration: Duration(seconds: 5),
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

class Ebola {
  String place;
  int quantity;
  Ebola(this.place, this.quantity);
}
