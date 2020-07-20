import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailScreen.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  String visitedfor, feedback,rate;
  @override
  void dispose() {
    _text.dispose();
    _text1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendingArgument arg = ModalRoute.of(context).settings.arguments;


    final _firestore = Firestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Feedback'),
          backgroundColor: Color(0xFFB22222)
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              'How was your appointment with \n ${arg.doctorname} ?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Divider(
              thickness: 5.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'For which health treatment/disease did you vist the doctor?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Eg : Cold,Fever etc (possibly one word)',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  Center(
                    child: Container(
                      width: 300.0,
                      child: TextField(
                        controller: _text,
                        decoration: InputDecoration(
                          labelText: 'Enter the Value',
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        ),
                        onChanged: (value) {
                          visitedfor = value;
                          print(visitedfor);

                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    thickness: 2.0,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Please leave a rating below based on your experience ?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Eg : 4.5 (keep the value between 0-5)',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  Center(
                    child: Container(
                      width: 300.0,
                      child: TextField(
                        controller: _text1,
                        decoration: InputDecoration(
                          labelText: 'Enter the Value',
                          errorText: _validate1
                              ? 'Enter the value in range(0-5)'
                              : null,
                        ),
                        onChanged: (value) {
                          rate = value;
                          print(rate);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    thickness: 2.0,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Please leave your feedback in the column below .',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: _text2,
                      decoration: InputDecoration(
                        labelText: "Enter Your Feedback here",
                        errorText: _validate2
                            ? 'Minimum 20 character required'
                            : null,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      onChanged: (val) {
                        feedback = val;
                        print(feedback);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(
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
                        if (_text2.text.isEmpty || _text2.text.toString().length<20) {
                          setState(() {
                            _validate2 = true;
                          });
                        } else {
                          print('ashay');
                          setState(() {
                            _validate2 = false;
                          });
                        }
                        try {
                          if (double.parse(_text1.text.toString()) < 0 ||
                              double.parse(_text1.text.toString()) > 5) {
                            setState(() {
                              _validate1 = true;
                            });
                          } else {
                            setState(() {
                              _validate1 = false;
                            });
                          }
                        } catch (e) {
                          setState(() {
                            _validate1 = true;
                          });
                        }

                        if (!_validate && !_validate1 && !_validate2) {
                          print('$rate $feedback $visitedfor ${DateTime.now()}');
                          _firestore
                              .collection(
                                  "doctors_auy/${arg.documentiD}/feedbacks")
                              .add({"name": "ashay","rating":rate,"visit":visitedfor,"feed":feedback,"date":DateTime.now()});
                          Navigator.pop(context);//${arg.docID}
                        }
                      }, //
                      child: Text('Submit'),
                      color: Colors.blue.shade100,
                      splashColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
