import 'package:flutter/material.dart';
import 'package:flutter_app/info.dart';
import 'package:flutter_app/theme.dart';

class Settings extends StatefulWidget{
  @override 
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ThemeSettings() )
              );
            },
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.color_lens, size: 30, color: Colors.grey[600],),
                    Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Appearance', style: TextStyle(fontSize: 17),),
                        Text('Change the colors of the app', style: TextStyle(color: Colors.grey[600]),)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Info())
              );
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.info, size: 30, color: Colors.grey[600],),
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
                Text('Info', style: TextStyle(fontSize: 17),)
              ],
            ),
          )
        ],
      ),
    );
  }
}