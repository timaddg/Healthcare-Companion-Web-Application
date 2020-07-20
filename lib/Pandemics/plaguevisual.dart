import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlagueVisual extends StatefulWidget {
  @override
  _PlagueVisualState createState() => _PlagueVisualState();
}

class _PlagueVisualState extends State<PlagueVisual> {
  final controller = ScrollController();
  double offset = 0;

  void initState() {
    super.initState();
    _Plaguedata = List<charts.Series<Plague, String>>();
    _generatePlague();
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

  List<charts.Series<Plague, String>> _Plaguedata;
  _generatePlague() {
    var data1 = [
      new Plague('Paris', 50000),
      new Plague('Florence', 65000),
      new Plague('London', 62000),
      new Plague('Cairo', 220000)
    ];
    _Plaguedata.add(
      charts.Series(
        domainFn: (Plague pg, _) => pg.place,
        measureFn: (Plague pg, _) => pg.quantity,
        id: '2019',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Plague pg, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff000000)),
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
          title: Text('Black Death'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'BLACK DEATH Statistics (deaths)',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _Plaguedata,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    //behaviors: [new charts.SeriesLegend()],
                    animationDuration: Duration(seconds: 5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    '   According to medieval historian Philip Daileader, it is likely that over four years, 45–50% of the European population died of the plague. Norwegian historian Ole Benedictow suggests is could have been as much as 60% of the European population. These numbers are not 100% accurate but are estiimated. Around 25 to 75 million people died because of Pandemics in Eurasia.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Plague {
  String place;
  int quantity;
  Plague(this.place, this.quantity);
}
