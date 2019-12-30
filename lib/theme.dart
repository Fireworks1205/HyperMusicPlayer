import 'package:flutter/material.dart';

class ThemeSettings extends StatefulWidget{
  @override 
  _ThemeSettingsState createState() => _ThemeSettingsState();
}



class _ThemeSettingsState extends State<ThemeSettings> {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10),),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(65, 0, 0, 0),),
              Text('Color Theme', style: TextStyle(color: Color.fromRGBO(15, 76, 129, 1))),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10),),
          FlatButton(
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Icon(Icons.color_lens, color: Colors.grey[600], size: 30,),
                Padding(padding: EdgeInsets.only(left: 20),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Theme', style: TextStyle(fontSize: 17),),
                    Text('Default(dark)', style: TextStyle(color: Colors.grey[600]),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}