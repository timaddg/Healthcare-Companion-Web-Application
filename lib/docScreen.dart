import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/detailScreen.dart';



class DocScreen extends StatefulWidget {
  DocScreen({this.depart});
  String depart;
  @override
  _DocScreenState createState() => _DocScreenState();
}

class _DocScreenState extends State<DocScreen> {
  @override
  final _firesore = Firestore.instance;
  List<DocumentSnapshot> doclist;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('List Of Doctors'),
          backgroundColor: Color(0xFFB22222)
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firesore.collection(widget.depart).snapshots(),
          builder: (context,snapshot){
            List<Container> ls=[];
            if(snapshot.hasData)
            {
              final meses=snapshot.data.documents;

              for(var m in meses)
              {

                var co=Container(child:
                GestureDetector(
                  onTap: () {
                  },
                  child: Container(

                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 40.0,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: m.data['name'],
                                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.7),

                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Colors.green,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: _firesore.collection('${widget.depart}/${m.documentID}/feedbacks').snapshots(),
                                          builder: (context, snapshot) {

                                            int comments=0;
                                            double rate=0;
                                            int totalComments=0;
                                            if(snapshot.hasData)
                                            {
                                              final commentList=snapshot.data.documents;

                                              double sum=0;
                                              for(var x in commentList) {

                                                sum+=double.parse(x.data['rating']);
                                              }
                                              rate=sum/commentList.length;
                                              totalComments=commentList.length;

                                            }
                                            if(totalComments==0)
                                              return Text(' 0.00 (0 Ratings)');
                                            else
                                            return Text('${rate.toStringAsFixed(2)} ($totalComments votes)');




                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.white,
                                child: Image.asset('images/icon.png'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(m.data['specialization'])
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.white,
                                child: Image.asset('images/student.png'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(m.data['education'])
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () async {
                                  //print('before async call');
                                 // var d= await getDetails(dID);
                                  // print('asfter async call ${d['name']}');
                                  Navigator.pushNamed(context, '/detailscreen',arguments:SendingDoc(doc:m.data,documentiD: m.documentID,collectionName: widget.depart));
                                },
                                child: Text('View Details'),
                                color: Colors.blue.shade100,
                                splashColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              MaterialButton(
                                onPressed: () {Navigator.pushNamed(context, '/slot',arguments:jimmy(docID: m.data['dID'],documentiD: m.documentID,collectionName: widget.depart) );},
                                child: Text('Book Now'),
                                color: Colors.blue.shade100,
                                splashColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),);
                ls.add(co);
              }

            }
            return Column(children: ls,);
          },
        )
      ),
    );
  }
}

class SendingDoc {
    final doc;
    var documentiD;
    var did;
    String collectionName;
  SendingDoc({this.doc,this.documentiD,this.did,this.collectionName});
}

class jimmy{
  var docID;
  var documentiD;
  String collectionName;
  jimmy({this.docID,this.documentiD,this.collectionName});
}
