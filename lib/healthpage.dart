import 'package:flutter/material.dart';
import 'package:health_app/ChartsPage.dart';
import 'package:health_app/Schemas/gov2.dart';
import 'package:health_app/disclaimer.dart';
import 'package:health_app/login.dart';
import 'package:health_app/register.dart';
import 'package:health_app/welcomescreen.dart';
import 'UserDetails/MaleOrFemalePage.dart';
import 'formscreen.dart';
import 'input_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/widgets.dart';
import 'formscreen.dart';
import 'Maps/MapPage.dart';
import 'Schemas/gov2.dart';
import 'UserDetails/main.dart';
import 'UserDetails/moreinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserDetails/blood.dart';

const activeCardColor = Color(0xFF1FA4EB);

class HealthPage extends StatefulWidget {
  static String id = 'main_screen';

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  List<Image> img = [
    Image.asset('images/apollo.png'),
    Image.asset('images/Aster.jpg'),
    Image.asset('images/victoria.jpeg'),
    Image.asset('images/msr.jpg'),
    Image.asset('images/fortis.jpg')
  ];
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    //print(email);
    runApp(MaterialApp(home: email == null ? LoginScreen() : HealthPage()));
  }

  createAlertDialog(BuildContext context) {
    TextEditingController mycontroller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Contact our Hospitals \n+912223336666',
              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
          );
        });
  }
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async{
    try {
      final user= await _auth.currentUser();
      if(user!=null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch (e){
      print(e);
    }
  }

  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFFB22222),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.map,
              size: 40,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(),
                  ),
                );
              });
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Healthcare Companion '),
              ),
            ),
            InkWell(
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(11, 12, 8, 12),
                    child: Image.asset('images/jenjawin190400208.jpg'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('user'),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails(),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                child: Card(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
                      child: Icon(Icons.edit),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Edit details'),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenderState(),
                          ),
                        );

                      });
                    },
                  ),
                ),
              ),
            ),



            InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Govt2Page(),
                    ),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 5, 0, 5),
                      child: Image.asset('images/health.jpeg'),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text('Health Schemes'),
                    ),
                    dense: true,
                  ),
                ),
              ),
            ),


            InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiscPage(),
                    ),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 5, 0, 5),
                      child: Image.asset('images/info.png'),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text('Disclaimer'),
                    ),
                    dense: true,
                  ),
                ),
              ),
            ),
            InkWell(
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 6, 10),
                    child: Image.asset('images/info.png'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('sign out'),
                  ),
                  onTap: () async {
                    //_auth.signOut();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                  },
                ),
              ),
            ),

          ],

        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChartsHomePage(),
                          ),
                        );
                      });
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Sparkline(
                          data: data,
                          lineColor: Colors.black54,
                          pointsMode: PointsMode.all,
                          pointSize: 5.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1.0,
                              blurRadius: 2.0)
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
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

                    GestureDetector(onTap: () {
                      createAlertDialog(context);
                      setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormScreen(),
                        ),
                      );

                    });},
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Center(
                          child: TypewriterAnimatedTextKit(
                            totalRepeatCount: 3,
                            text: ['EMERGENCY'],
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
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
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
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                              left: 2.0,
                              top: 30.0,
                              child: Text(" Consult \n our Doctors!")),
                          Positioned(
                              right: 0.2,
                              child: Image.asset(
                                'images/docpic.png',
                                width: 68.0,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputPage(),
                          ),
                        );
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(3.0),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "BMI \nCALCULATOR",
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            child: Image.asset(
                              'images/info.png',
                              width: 22.0,
                            ),
                          ),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodScreen(),
                          ),
                        );
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(3.0),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "BLOOD \nDONATION",
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                            right: 0.9,
                            child: Image.asset(
                              'images/red.jpg',
                              width: 22.0,
                            ),
                          ),
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
                      width: 350.0,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFB22222),
        child: Icon(Icons.help),
        onPressed: () {
          createAlertDialog(context);
        },
      ),
    );
  }
}

class Reuse extends StatelessWidget {
  Reuse({
    @required this.colour,
    this.cardChild,
  });
  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
