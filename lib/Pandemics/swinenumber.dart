import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SwineVisual extends StatefulWidget {
  @override
  _SwineVisualState createState() => _SwineVisualState();
}

class _SwineVisualState extends State<SwineVisual> {
  final controller = ScrollController();
  double offset = 0;

  void initState() {
    super.initState();
    _swinedata = List<charts.Series<SwineFlu, String>>();
    _generateswine();
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

  List<charts.Series<SwineFlu, String>> _swinedata;
  _generateswine() {
    var data1 = [
      new SwineFlu('USA', 113690),
      new SwineFlu('Brazil', 58178),
      new SwineFlu('India', 33783),
      new SwineFlu('France', 1980000),
      new SwineFlu('Germany', 222360)
    ];
    _swinedata.add(
      charts.Series(
        domainFn: (SwineFlu cv, _) => cv.place,
        measureFn: (SwineFlu cv, _) => cv.quantity,
        id: '2019',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (SwineFlu cv, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff006400)),
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
          title: Text('Swine Flu'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Swine Influenza',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _swinedata,
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

class SwineFlu {
  String place;
  int quantity;
  SwineFlu(this.place, this.quantity);
}
