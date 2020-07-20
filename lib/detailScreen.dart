import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'docScreen.dart';


class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String feedback='erasdad aaaaaaaaaaa';
  final _firestore=Firestore.instance;
  double rate=0;
  int totalComments=0;
  List<String> days = [
    "Monday",
    "Tuesday",
    "wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> slots = ["morning", "afternoon", "evening"];
  bool _clickAbout=false;
  bool _clickeducation=false;
  bool _clickexperience=false;
  bool _clickAward=false;
  bool _clickMember=false;
  bool _clickRegisteration=false;

  void setting(double x,int y){
    setState(() {
      rate=x;
      totalComments=y;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SendingDoc arg = ModalRoute.of(context).settings.arguments;






      List<Widget> timing = [];
      List arr = [];
      for (int i = 0; i < arg.doc['availability'].length; i++) {
        if (!arg.doc['availability'][i].isEmpty)
          arr.add([days[i], arg.doc['availability'][i]]);
      }
      for (int i = 0; i < arr.length; i++) {
        var a = null;
        List b = [];
        a = Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.only(top: 15.0, left: 20.0),
          child: Text('${arr[i][0]}'),
          constraints:
          BoxConstraints(minWidth: 100.0, minHeight: 50.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.green.shade50,
          ),
        );
        for (int j = 0; j < 3; j++) {
          try {
            arr[i][1][slots[j]];
            List temp = arr[i][1][slots[j]];
            String value =
                "${temp[0]}:00 ${temp[0] < 11.99
                ? 'AM'
                : 'PM'} - ${temp[1]}:00 ${temp[1] < 11.99 ? 'AM' : 'PM'} ";
            b.add(Column(
              children: <Widget>[
                Container(child: Text("${slots[j]}",
                  style: TextStyle(fontWeight: FontWeight.w500),)),
                Container(
                  child: Text(value),
                ),
                Divider(
                  color: Colors.black,
                )
              ],
            ));
          } catch (e) {}
        }
        var second = Column(
          children: List.generate(b.length, (index) {
            return b[index];
          }),
        );
        timing.add(Row(children: <Widget>[
          a,
          SizedBox(
            width: 50.0,
          ),
          second
        ]));
        timing.add(Divider());
      }

     double x=0;
     int y=0;
    //DateTime date = DateTime.now();

    Row getActive(){
      int day=DateTime.now().weekday-1;

      try {
          arg.doc['week'][day];
        return Row(
          children: <Widget>[
            Icon(Icons.check_circle_outline,color: Colors.green,),
            Text('Visits Today',style: TextStyle(color: Colors.green),),
          ],
        );
      }catch(e){
        return Row(
          children: <Widget>[
            Icon(Icons.close,color: Colors.red,),
            Text('Not Available Today',style: TextStyle(color: Colors.red),),
          ],
        ) ;
      }
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text('Doctor Details'),
          backgroundColor: Color(0xFFB22222)
      ),
      body: Container(
        margin: EdgeInsets.only(top:10.0,left: 10.0,right: 10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, right: 3.0, left: 3.0),
                    padding: EdgeInsets.all(10.0),
                    constraints: BoxConstraints(minHeight: 200.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1.0,
                              blurRadius: 2.0)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
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
                                      text: arg.doc['name'],
                                      style: TextStyle(color: Colors.black,fontSize: 20.0),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(arg.doc['designation']),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text('${arg.doc['exp']} Years of overall experience'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.face,
                              color: Colors.green,
                            ),
                            Text(
                              '  ${rate.toStringAsFixed(2)} ($totalComments votes)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.green),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                CircleAvatar(
                                  child: Image.asset('images/student.png'),
                                  radius: 10.0,
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(width: 5.0,),
                                Text(arg.doc['education'])
                              ],
                            )
                          ],
                        ),
                        getActive(),
                      ],
                    ),
                  ),

                  Container(padding: EdgeInsets.all(10.0),

                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[Text('FeedBack For ${arg.doc['name']} ',style: TextStyle(fontSize: 17.0,fontWeight:FontWeight.w500),),
                                         Divider(),
                                         Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: <Widget>[Wrap(children:<Widget>[ Text('Leave a Feedback\n and help us improve',style: TextStyle(fontWeight: FontWeight.w500),)]),MaterialButton(child: Text('Feedback'),textColor: Colors.black,onPressed: (){Navigator.pushNamed(context, '/feed',arguments: sendingArgument(docID:arg.doc['dID'],doctorname: arg.doc['name'],documentiD: arg.documentiD));},shape: OutlineInputBorder(),)],),
                                         Divider(),
                                          Text('Showing few feedBack:',style: TextStyle(fontWeight: FontWeight.w500)),
                                          Text('These feedbacks are completely based on user opinion and will not repesent Doctor\'s medical capability'),
                                         Divider(),


                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('${arg.collectionName}/${arg.documentiD}/feedbacks').snapshots(),
                          builder: (context, snapshot) {

                            List comments=[];
                            if(snapshot.hasData)
                            {
                              final commentList=snapshot.data.documents;
                              double sum=0;
                              for(var x in commentList)
                              {
                                sum+=double.parse(x.data['rating']);
                              }

                              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                                rate=sum/commentList.length;
                                totalComments=commentList.length;
                              }));


                              if(commentList.length<4)
                              {
                                for(var x in commentList)
                                {
                                  comments.add(new commentArgument(name:x.data['name'],rate: x.data['rating'],visitedFor:x.data['visit'],feed: x.data['feed'],days: DateTime.now().difference(DateTime.parse(x.data['date'].toDate().toString())).inDays ));
                                }

                              }
                              else{

                                for(int i=0;i<3;i++)
                                {
                                  comments.add(new commentArgument(name:commentList[i]['name'],rate: commentList[i]['rating'],visitedFor:commentList[i]['visit'],feed: commentList[i]['feed'],days: DateTime.now().difference(DateTime.parse(commentList[i].data['date'].toDate().toString())).inDays ));
                                }
                              }



                            }
                            if(comments.length==0)
                            {
                              return Center(child: Text('No Comments yet'),);

                            }
                            else
                            {
                              return  Column(children:  List.generate(comments.length<=3?comments.length:3, (index){return  Wrap(children: <Widget>[ Stack(children: <Widget>[CircleAvatar(radius: 20.0,backgroundColor: Colors.blueAccent,child: Text(comments[index].name[0].toUpperCase()),),Align(alignment:Alignment(0.5, 0.1),child: Container(constraints: BoxConstraints(maxWidth: 300.0),child: Column(mainAxisAlignment:MainAxisAlignment.spaceAround,crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[Text(comments[index].name),SizedBox(height: 10.0,),Text('${comments[index].rate}/5',style: TextStyle(color: Colors.orange),),Text('Visited for ${comments[index].visitedFor}',style: TextStyle(fontWeight: FontWeight.bold),),ShowMore(text:comments[index].feed,),],))),Align(alignment: Alignment.topRight,child: Text('${comments[index].days} days ago'),)],),
                                Divider(),],);}),) ;
                            }




                          },
                        ),


                                         GestureDetector(onTap:(){Navigator.pushNamed(context, '/allfeed',arguments: documentIDSending(documentiD:arg.documentiD,collectionName: arg.collectionName));},child: Container(padding:EdgeInsets.all(10.0),child: Text('Read all feedback',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 17.0),))),
                                         Divider(thickness: 2.0,)


                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top:10.0),color: Colors.white,
                    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[Container(padding:EdgeInsets.all(10.0),child: Text('Availability and Services',style: TextStyle(fontWeight: FontWeight.bold),)),
                                 Divider(),
                                 Row(children: <Widget>[Icon(Icons.access_time),SizedBox(width: 7.0,),Text('Timings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),)],),
                                 SizedBox(height: 10.0,),
                      Container(child: Column(children: timing.length!=0?timing:Container(child: Text('Doctor Not Available',style: TextStyle(color: Colors.red),),))),
                                 SizedBox(height: 40.0,),
                                 Row(children: <Widget>[Icon(Icons.event_note),SizedBox(width: 7.0,),Text('Services',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),)],),
                      arg.doc['services'].length!=0?Container(
                        child: Wrap(
                          children: List.generate( arg.doc['services'].length, (index) {
                            return Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: Text('${ arg.doc['services'][index]}'),
                              constraints:
                              BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green.shade50,
                              ),
                            );
                          }),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ):Container(child:Center(child: Text("No Special services Offered by the doctor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),))),
                         ],) ,),


      Container(margin: EdgeInsets.only(top:7.0),color: Colors.white,child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
        Text('More Information about the Doctor',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 5.0,),
        Divider(),
        InkWell(onTap: (){
          setState(() {
            _clickAbout=!_clickAbout;
          });
        },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
                    _clickAbout? Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios)
                  ],
                ),
                _clickAbout?Text(arg.doc['about']==''?'No details yet':arg.doc['about']):Text(''),
              ],)),
        ),
        Divider(),
        InkWell(onTap: (){
          setState(() {
            _clickeducation=!_clickeducation;
          });
        },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Education',style: TextStyle(fontWeight: FontWeight.bold),),
                    _clickeducation? Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios)
                  ],
                ),
                _clickeducation?Text(arg.doc['edu']==''?'No details yet':arg.doc['edu']):Text(''),
              ],)),
        ),
        Divider(),
        InkWell(onTap: (){
          setState(() {
            _clickexperience=!_clickexperience;
          });
        },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Experience',style: TextStyle(fontWeight: FontWeight.bold),),
                    _clickexperience? Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios)
                  ],
                ),
                _clickexperience?Text(arg.doc['experience']==''?'No details yet':arg.doc['experience']):Text(''),
              ],)),
        ),
        Divider(),
        InkWell(onTap: (){
          setState(() {
            _clickAward=!_clickAward;
          });
        },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Awards of recognition',style: TextStyle(fontWeight: FontWeight.bold),),
                    _clickAward? Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios)
                  ],
                ),
                _clickAward?Text(arg.doc['award']==''?'No details yet':arg.doc['award']):Text(''),
              ],)),
        ),
        Divider(),
        InkWell(onTap: (){
          setState(() {
            _clickMember=!_clickMember;
          });
        },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Membership',style: TextStyle(fontWeight: FontWeight.bold),),
                    _clickMember? Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios)
                  ],
                ),
                _clickMember?Text(arg.doc['member']==''?'No details yet':arg.doc['member']):Text(''),
              ],)),
        ),
        Divider(),
        InkWell(onTap: (){
          setState(() {
            _clickRegisteration=!_clickRegisteration;
          });
        },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registeration',style: TextStyle(fontWeight: FontWeight.bold),),
                    _clickRegisteration? Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios)
                  ],
                ),
                _clickRegisteration?Text(arg.doc['register']==''?'No details yet':arg.doc['register']):Text(''),
              ],)),
        ),
        Divider(),

      ],),),


                ],
              ),
            ),

            //SliverToBoxAdapter(child: Container(height: 150.0,child: Container(width: 75.0,child: ListView.builder(itemBuilder: (context,index){return Card(child: Text('ashay'),color: Colors.blue,);},itemCount: 3,),),),),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.grey.shade100,
        child: Center(
          child: MaterialButton(
            onPressed: () {Navigator.pushNamed(context, '/slot',arguments: sendingArgument(docID:arg.doc['dID'],documentiD: arg.documentiD,collectionName: arg.collectionName));},
            child: Text('Book Now'),
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

class ShowMore extends StatefulWidget {
  String text;
  ShowMore({this.text});
  @override
  _ShowMoreState createState() => _ShowMoreState();
}

class _ShowMoreState extends State<ShowMore> {
  String firsthalf;
  String secondhalf;
  bool flag=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>15)
       {
         firsthalf = widget.text.substring(0, 15);
         secondhalf = widget.text.substring(15, widget.text.length);
       }
    else
      {
        firsthalf = widget.text;
        secondhalf='';

      }

  }
  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.all(1.0),child: secondhalf.isEmpty?Text(firsthalf):Row(children: <Widget>[Flexible(child: Text(flag?firsthalf+'...':firsthalf+secondhalf,)),InkWell(child: Text(flag?'show more':'show less',style: TextStyle(color: Colors.orange),),onTap: (){setState(() {
      flag=!flag;
    });},)],),);
  }
}

class sendingArgument extends jimmy{
  var docID;
  var doctorname;
  var documentiD;
  String collectionName;
  sendingArgument({this.docID,this.doctorname,this.documentiD,this.collectionName});

}


class commentArgument{
  var name;
  var rate;
  var visitedFor;
  var feed;
  int days;
  commentArgument({this.name,this.rate,this.visitedFor,this.feed,this.days});
}

class documentIDSending{
 var  documentiD;
 String collectionName;
 documentIDSending({this.documentiD,this.collectionName});

}