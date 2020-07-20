import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VirusPage extends StatefulWidget {
  @override
  _VirusPageState createState() => _VirusPageState();
}

class _VirusPageState extends State<VirusPage> {
  final controller = ScrollController();
  double offset = 0;

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

  List<charts.Series<Corona, String>> _coronadata;
  _generatecovid() {
    var data1 = [
      new Corona('USA', 5.97),
      new Corona('UK', 14.35),
      new Corona('India', 3.15),
      new Corona('Brazil', 6.7),
      new Corona('Russia', 0.93),
      new Corona('Spain', 9.96),
      new Corona('Italy', 15.5),
    ];
    _coronadata.add(
      charts.Series(
        domainFn: (Corona cv, _) => cv.place,
        measureFn: (Corona cv, _) => cv.quantity,
        id: '2019',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Corona cv, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
  }

  void initState() {
    super.initState();
    _coronadata = List<charts.Series<Corona, String>>();
    _generatecovid();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'COVID-19 Projected Death Rates',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: charts.BarChart(
                    _coronadata,
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

class Corona {
  String place;
  double quantity;

  Corona(this.place, this.quantity);
}
