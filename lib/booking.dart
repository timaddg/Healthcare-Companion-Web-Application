import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_app/appoint_slot.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final _firestore=Firestore.instance;
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;
  bool _success = false;
  var document;
  String patient,pno;





  @override
  Widget build(BuildContext context) {
    final appointData arg = ModalRoute.of(context).settings.arguments;

    List<String> ls = [];
    Map name;




    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booking'),
          backgroundColor: Color(0xFFB22222)
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 40.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: arg.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text("${arg.desig}"),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text('${arg.exp} Years of overall experience'),
                          ],
                        ),
                      ),
                    ],
                  ),
        StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection(arg.collectionName).document(arg.documentiD).snapshots(),
          builder: (context, snapshot) {

            List arr=[];

            if (snapshot.hasData) {
              final m=snapshot.data;


              arr=m.data['availability'];



              name = m.data['appointment'];




            }

            return Text('');

          },
        )
                ],
              ),
            ),
            Divider(
              thickness: 3.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Reason of Booking',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    "Consultation",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date and Time',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    "${arg.date.day}/${arg.date.month}/${arg.date.year}  time slot:${arg.slot}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter patient Details',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  Divider(),
                  Text(
                    'Name : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: TextField(
                      controller: _text,
                      decoration: InputDecoration(
                        labelText: 'Enter the Value',
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      ),
                      onChanged: (value) {
                        patient=value;
                      },
                    ),
                  ),
                  Divider(),
                  Text(
                    'Phone Number : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: TextField(
                      controller: _text1,
                      decoration: InputDecoration(
                        labelText: 'Enter the Value',
                        errorText: _validate1
                            ? 'Enter a valid 10 digit phone number'
                            : null,
                      ),
                      onChanged: (value) {
                        pno=value;
                      },
                    ),
                  )
                ],
              ),
              constraints: BoxConstraints(minHeight: 250.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 1.0, blurRadius: 2.0)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Center(child: Text(_success?'your appointment has been booked':'',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 17.0),),),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        color: Colors.grey.shade300,
        child: Center(
          child: MaterialButton(
            onPressed: () {


              if (_text.text.isEmpty) {
                setState(() {
                  _validate = true;
                });
              } else {
                setState(() {
                  _validate = false;
                });
              }
              try{
                int.parse(_text1.text.toString());
                if(_text1.text.toString().length!=10)
                  {
                    setState(() {
                      _validate1=true;
                    });
                  }
                else{
                  setState(() {
                    _validate1 = false;
                  });

                }
              }catch(e){
                setState(() {
                  _validate1 = true;
                });
              }



              if (!_validate && !_validate1){

                if(name['${arg.date.day}/${arg.date.month}']==null)
                {
                  name['${arg.date.day}/${arg.date.month}']={arg.slot:{"name":patient,"pno":pno,"appointId":'${arg.docID}${arg.date.day}${arg.date.month}${arg.slot}'}};

                }
                else{
                  name['${arg.date.day}/${arg.date.month}'][arg.slot]={"name":patient,"pno":pno,"appointId":'${arg.docID}${arg.date.day}${arg.date.month}${arg.slot}'};
                }

                _firestore.collection(arg.collectionName).document(arg.documentiD).updateData({"appointment":name});
                setState(() {
                  _success=true;
                });
                Navigator.pop(context);
              }


            },
            child: Text('Confirm'),
            color: Colors.blue.shade100,
            splashColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
          ),
        ),
      ),
    );
  }
}
