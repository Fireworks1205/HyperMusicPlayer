import 'package:flutter/material.dart';

class Info extends StatefulWidget{
  @override 
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Card(
        child: Container(
          height: 200,
          width: 500,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0),),
                Text('Hyper Music Player', style: TextStyle(fontSize: 30),),
                Text('Version: 2.0.3'),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
                Text('By Fireworks'),
                Text('Developed by using Flutter'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}