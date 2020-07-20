import 'package:flutter/material.dart';
import 'docScreen.dart';

class OnlineAppointment extends StatelessWidget {
  List<Image> dataList=[Image.asset('images/ayurvedic-bowl.png'),Image.asset('images/child.png'),Image.asset('images/teeth.png'),Image.asset('images/skin.png'),Image.asset('images/diabetes.png'),Image.asset('images/fruit.png'),Image.asset('images/cough.png'),Image.asset('images/eye.png'),Image.asset('images/stomach.png'),Image.asset('images/doctor.png'),Image.asset('images/pelvic-area.png'),Image.asset('images/cardiovascular.png'),Image.asset('images/leaf.png'),Image.asset('images/brain.png'),Image.asset('images/orthopedics.png'),Image.asset('images/healthcare-and-medical.png'),Image.asset('images/kidney.png'),];
  List<Wrap> dataText=[Wrap(children: <Widget>[Text('Ayurveda')],),Wrap(children: <Widget>[Text('Paediatrics')],),Wrap(children: <Widget>[Text('Dental Surgery')],),Wrap(children: <Widget>[Text('Dermatologist')],),Wrap(children: <Widget>[Text('Diabetology')],),Wrap(children: <Widget>[Text('Dietitian')],),Wrap(children: <Widget>[Text('ENT')],),Wrap(children: <Widget>[Text('Ophthalmology')],),Wrap(children: <Widget>[Text('Gastroenterology')],),Wrap(children: <Widget>[Text('Physician')],),Wrap(children: <Widget>[Text('Obstetrics and Gynaecology')],),Wrap(children: <Widget>[Text('Cardiology')],),Wrap(children: <Widget>[Text('Homeopathy')],),Wrap(children: <Widget>[Text('Neurology')],),Wrap(children: <Widget>[Text('Orthopaedics')],),Wrap(children: <Widget>[Text('Physiotherapy')],),Wrap(children: <Widget>[Text('Urology')],),];
  List<String> navi=['/ayur'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Color(0xFFB22222),
        title: Text('Search Doctors'),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(dataList.length, (index) {
            return GestureDetector(onTap: (){Navigator.pushNamed(context, '/ayur');},
              child: Card(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[CircleAvatar(child: dataList[index],backgroundColor: Colors.white,), SizedBox(height: 10.0,),dataText[index]],
                ),

              ),
            );
          }),
        ),
      ),
    );
  }
}
