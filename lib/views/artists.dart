import 'package:flutter/material.dart';

class Artists extends StatefulWidget {
  @override 
  _ArtistsState createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(top: BorderSide(color: Colors.grey))
        ),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 10),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10.0),),
                Text('Artists', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Padding(padding: EdgeInsets.only(top: 10.0),),
              ],
            )
          ],
        ),
      ),
    );
  }
}