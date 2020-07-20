import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'detailScreen.dart';
import 'docScreen.dart';

class AppointmentSlot extends StatefulWidget {
  @override
  _AppointmentSlotState createState() => _AppointmentSlotState();
}

class _AppointmentSlotState extends State<AppointmentSlot>
    with SingleTickerProviderStateMixin {
  final _firesore = Firestore.instance;
  TabController _tabController;
  static DateTime defaultStart;
  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<Container> dates;
  List<String> forDateRet;
  List<DateTime> referenceDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultStart = DateTime.now();


    getDates();
    _tabController = TabController(length: dates.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  void getDates() {
    DateTime temp, anotherTemp;

    temp = anotherTemp = DateTime.now();
    dates = List<Container>();
    referenceDate=List<DateTime>();
    forDateRet=[];

    for (int i = 0; i < 15; i++) {
      temp = DateTime.utc(
          defaultStart.year, defaultStart.month, defaultStart.day + i);
      var addable = Container(
        margin: EdgeInsets.all(5.0),
        width: 150.0,
        height:100.0,
        child: Column(
          children: <Widget>[
            Text(
              '  ${temp.day}\n${months[temp.month - 1]}',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.redAccent, width: 1)),
      );
      dates.add(addable);
      forDateRet.add('${temp.day}/${temp.month}');
      referenceDate.add(temp);
    }
  }

  //minutes interval
  var times = []; // time array
  // start time
  void getSlots(int tt, int end) {
    var x = 15;
    tt = tt * 60;
    var ap = ['AM', 'PM'];
    for (var i = 0; tt < end * 60; i++) {
      var hh = (tt / 60).floor(); // getting hours of day in 0-24 format
      var mm = (tt % 60); // getting minutes of the hour in 0-55 format
      var s = (("0${(hh % 12)}").substring("0${(hh % 12)}".length - 2) == "00"
              ? "12"
              : ("0${(hh % 12)}").substring("0${(hh % 12)}".length - 2)) +
          ':' +
          ("0$mm").substring("0$mm".length - 2) +
          ap[(hh / 12)
              .floor()]; // pushing data in array in [00:00 - 12:00 AM/PM format]
      times.add(s);
      tt = tt + x;
    }
  }

  @override
  Widget build(BuildContext context) {

    final jimmy arg = ModalRoute.of(context).settings.arguments;
    print(arg.documentiD);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(preferredSize: Size(150.0,100.0),
              child: Container(height: 70.0,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.redAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent),
                  tabs: dates,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: List.generate(dates.length, (index) {
              DateTime send=referenceDate[index];
              return Container(
                margin: EdgeInsets.all(10.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Morning -Slots',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firesore.collection(arg.collectionName).document(arg.documentiD).snapshots(),
                      builder: (context, snapshot) {

                        List<String> ls = [];
                         List arr=[];
                        if (snapshot.hasData) {
                           final m=snapshot.data;

                           times = [];
                           arr=m.data['availability'];

                           try{
                             getSlots(arr[referenceDate[index].weekday-1]['morning'][0], arr[referenceDate[index].weekday-1]['morning'][1]);
                           }
                           catch(e){ return SliverToBoxAdapter(child: Container(
                             child: Center(child: Container(
                               margin: EdgeInsets.all(5.0),
                               padding: EdgeInsets.only(top: 15.0, left: 10.0,right: 10.0),
                               child: Text('Doctor Not Available'),
                               constraints:
                               BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                               decoration: BoxDecoration(
                                 shape: BoxShape.rectangle,
                                 borderRadius: BorderRadius.circular(10.0),
                                 color: Colors.green.shade50,
                               ),
                             )),),);}
                           String da=forDateRet[index];
                           var name = m.data['appointment'][forDateRet[index]];

                           if(name==null)
                           {
                             for (int i = 0; i < times.length; i++) {
                               ls.add(times[i]);

                             }
                           }
                           else {
                             for (int i = 0; i < times.length; i++) {
                               if (name[times[i]] == null) {
                                 ls.add(times[i]);
                               }
                             }
                           }

                           return arr[referenceDate[index].weekday-1].isEmpty?SliverToBoxAdapter(child: Container(child: Center(child: Text("Doctor Not Available")),) ,) :  SliverGrid.count(
                             crossAxisSpacing: 10.0,
                             mainAxisSpacing: 1.0,
                             crossAxisCount: 4,
                             children: List.generate(ls.length, (index) {
                               return GestureDetector(onTap: (){Navigator.pushNamed(context, '/booking',arguments: appointData(docID: arg.docID,name: m.data['name'],desig: m.data['designation'],date:send ,slot: ls[index],exp: m.data['exp'],documentiD:arg.documentiD,collectionName: arg.collectionName));},
                                 child: Card(
                                   child: Center(child: Text(ls[index])),
                                 ),
                               );
                             }),
                           );

                        }

                      return SliverToBoxAdapter(child: Container(child: Text("Doctor"),) ,);

                      },
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Center(  
                          child: Text(
                            'Afternoon Slots',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firesore.collection(arg.collectionName).document(arg.documentiD).snapshots(),
                      builder: (context, snapshot) {
                        List<String> ls = [];
                        List arr=[];
                        if (snapshot.hasData) {
                          final m=snapshot.data;

                          times = [];
                          arr=m.data['availability'];

                          try{
                            getSlots(arr[referenceDate[index].weekday-1]['afternoon'][0], arr[referenceDate[index].weekday-1]['afternoon'][1]);
                          }
                          catch(e){ return SliverToBoxAdapter(child: Container(
                            child: Center(child: Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(top: 15.0, left: 10.0,right: 10.0),
                              child: Text('Doctor Not Available'),
                              constraints:
                              BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green.shade50,
                              ),
                            )),),);}
                          String da=forDateRet[index];
                          var name = m.data['appointment'][forDateRet[index]];

                          if(name==null)
                          {
                            for (int i = 0; i < times.length; i++) {
                              ls.add(times[i]);

                            }
                          }
                          else {
                            for (int i = 0; i < times.length; i++) {
                              if (name[times[i]] == null) {
                                ls.add(times[i]);
                              }
                            }
                          }

                          return arr[referenceDate[index].weekday-1].isEmpty?SliverToBoxAdapter(child: Container(child: Center(child: Text("Doctor Not Available")),) ,) :  SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 1.0,
                            crossAxisCount: 4,
                            children: List.generate(ls.length, (index) {
                              return GestureDetector(onTap: (){Navigator.pushNamed(context, '/booking',arguments: appointData(docID: arg.docID,name: m.data['name'],desig: m.data['designation'],date:send ,slot: ls[index],exp: m.data['exp'],documentiD:arg.documentiD,collectionName: arg.collectionName));}  ,
                                child: Card(
                                  child: Center(child: Text(ls[index])),
                                ),
                              );
                            }),
                          );

                        }

                        return SliverToBoxAdapter(child: Container(child: Text("Doctor"),) ,);

                      },
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Evening - Slots',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firesore.collection(arg.collectionName).document(arg.documentiD).snapshots(),
                      builder: (context, snapshot) {
                        List<String> ls = [];
                        List arr=[];
                        if (snapshot.hasData) {
                          final m = snapshot.data;

                          times = [];
                          arr = m.data['availability'];
                        try{
                          getSlots(arr[referenceDate[index].weekday-1]['evening'][0], arr[referenceDate[index].weekday-1]['evening'][1]);
                          }
                          catch(e){ return SliverToBoxAdapter(child: Container(
                            child: Center(child:Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(top: 15.0, left: 10.0,right: 10.0),
                              child: Text('Doctor Not Available'),
                              constraints:
                              BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green.shade50,
                              ),
                            )),),);}
                          String da = forDateRet[index];
                          var name = m.data['appointment'][forDateRet[index]];

                          if (name == null) {
                            for (int i = 0; i < times.length; i++) {
                              ls.add(times[i]);
                            }
                          }
                          else {
                            for (int i = 0; i < times.length; i++) {
                              if (name[times[i]] == null) {
                                ls.add(times[i]);
                              }
                            }
                          }

                          return arr[referenceDate[index].weekday - 1].isEmpty
                              ? SliverToBoxAdapter(child: Container(
                            child: Center(child: Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(top: 15.0, left: 10.0,right: 10.0),
                              child: Text('Maximum appointments are booked for the day'),
                              constraints:
                              BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green.shade50,
                              ),
                            )),),)
                              : SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 1.0,
                            crossAxisCount: 4,
                            children: List.generate(ls.length, (index) {
                              return GestureDetector(onTap: (){Navigator.pushNamed(context, '/booking',arguments: appointData(docID: arg.docID,name: m.data['name'],desig: m.data['designation'],date:send ,slot: ls[index],exp: m.data['exp'],documentiD:arg.documentiD,collectionName: arg.collectionName));},
                                child: Card(
                                  child: Center(child: Text(ls[index])),
                                ),
                              );
                            }),
                          );
                        }

                        return SliverToBoxAdapter(child: Container(child: Text("Doctor"),) ,);

                      },
                    ),

                  ],
                ),
              );
            })),
      ),
    );
  }
}

class appointData{

  DateTime date;
  var slot;
  var docID;
  var name;
  var desig;
  var exp;
  var documentiD;
  String collectionName;

  appointData({this.docID,this.name,this.desig,this.date,this.slot,this.exp,this.documentiD,this.collectionName});

}