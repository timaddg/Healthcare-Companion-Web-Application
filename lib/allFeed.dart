import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/detailScreen.dart';


class AllFeed extends StatefulWidget {
  @override
  _AllFeedState createState() => _AllFeedState();
}

class _AllFeedState extends State<AllFeed> {
  final _firestore=Firestore.instance;
  @override
  Widget build(BuildContext context) {
    final documentIDSending arg = ModalRoute.of(context).settings.arguments;
    //print(arg.documentiD);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedbacks'),
          backgroundColor: Color(0xFFB22222)

      ),
      body: ListView(children: <Widget>[
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('${arg.collectionName}/${arg.documentiD}/feedbacks').snapshots(),
          builder: (context, snapshot) {

            List comments=[];
            if(snapshot.hasData)
            {
              final commentList=snapshot.data.documents;


              for(var x in commentList)
                {
                  comments.add(new commentArgument(name:x.data['name'],rate: x.data['rating'],visitedFor:x.data['visit'],feed: x.data['feed'],days: DateTime.now().difference(DateTime.parse(x.data['date'].toDate().toString())).inDays ));
                }




            }
            if(comments.length==0)
            {
              return Center(child: Text('No Comments yet'),);

            }
            else
            {
              return  Column(children:  List.generate(comments.length, (index){return  Wrap(children: <Widget>[ Stack(children: <Widget>[CircleAvatar(radius: 20.0,backgroundColor: Colors.blueAccent,child: Text(comments[index].name[0].toUpperCase()),),Align(alignment:Alignment(0.5, 0.1),child: Container(constraints: BoxConstraints(maxWidth: 300.0),child: Column(mainAxisAlignment:MainAxisAlignment.spaceAround,crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[Text(comments[index].name),SizedBox(height: 10.0,),Text('${comments[index].rate}/5',style: TextStyle(color: Colors.orange),),Text('Visited for ${comments[index].visitedFor}',style: TextStyle(fontWeight: FontWeight.bold),),ShowMore(text:comments[index].feed,),],))),Align(alignment: Alignment.topRight,child: Text('${comments[index].days} days ago'),)],),
                Divider(),],);}),) ;
            }




          },
        ),
      ],),
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



class commentArgument{
  var name;
  var rate;
  var visitedFor;
  var feed;
  int days;
  commentArgument({this.name,this.rate,this.visitedFor,this.feed,this.days});
}
