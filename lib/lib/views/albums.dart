import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

class AlbumView extends StatefulWidget{
  @override 
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
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
            Padding(padding: EdgeInsets.only(left: 10.0),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10.0),),
                Text('Albums', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.left,),
                Padding(padding: EdgeInsets.only(top: 10.0),),
              ],
            )
          ],
        ),
      )
    );
  }
}