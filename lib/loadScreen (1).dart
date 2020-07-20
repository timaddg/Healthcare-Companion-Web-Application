import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/painting.dart';

class loadScreen extends StatefulWidget {
  @override
  _loadScreenState createState() => _loadScreenState();
}

class _loadScreenState extends State<loadScreen> {
  List<Image> img = [
    Image.asset('images/health1.jpeg'),
    Image.asset('images/health2.jpeg'),
    Image.asset('images/health3.jpeg'),
    Image.asset('images/health4.jpeg'),
    Image.asset('images/health5.jpeg')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    constraints: BoxConstraints.tightFor(height: 200.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1.0,
                              blurRadius: 5.0)
                        ],
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  Divider(),
                  Container(
                    child: Text(
                      "What are you looking for ?",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: Center(
                      child: TypewriterAnimatedTextKit(
                        totalRepeatCount: 3,
                        text: ['emergency'],
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: Duration(milliseconds: 500),
                      ),
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1.0,
                              blurRadius: 2.0)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/appointment');
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(3.0),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 2.0,
                            top: 3.0,
                            child: Text(
                              "Book Appointment?",
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                              left: 2.0,
                              top: 30.0,
                              child: Text("click here to meet\nour doctors!")),
                          Positioned(
                              right: 0.9,
                              child: Image.asset(
                                'images/docpic.png',
                                width: 80.0,
                              ))
                        ],
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1.0,
                                blurRadius: 2.0)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  Container(
                    color: Colors.orange,
                  ),
                  Container(
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      width: 300.0,
                      child: img[index],
                    );
                  },
                  itemCount: 5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
