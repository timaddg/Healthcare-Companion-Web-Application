import 'package:flutter/material.dart';
import 'package:health_app/welcomescreen.dart';
import 'allFeed.dart';
import 'loadScreen (1).dart';
import 'login.dart';
import 'register.dart';
import 'package:flutter/widgets.dart';
import 'welcomescreen.dart';
import 'booking.dart';


//import 'loadScreen.dart';
import 'onlineAppointment.dart';
import 'docScreen.dart';
import 'detailScreen.dart';
import 'feedbackForm.dart';
import 'appoint_slot.dart';

const activeCardColor = Color(0xFF1FA4EB);

void main() => runApp(
      MaterialApp(
        home: Health(),
      ),
    );

class Health extends StatefulWidget {
  static String id = 'main_screen';
  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        '/':(context)=>loadScreen(),
        '/appointment':(context)=>OnlineAppointment(),
        '/ayur':(context)=>DocScreen(depart: 'doctors_auy',),
        '/detailscreen':(context)=>DetailScreen(),
        '/slot':(context)=>AppointmentSlot(),
        '/booking':(context)=>Booking(),
        '/feed':(context)=>FeedBack(),
        '/allfeed':(context)=>AllFeed(),
      },
    );
  }
}
