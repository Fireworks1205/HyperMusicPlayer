import 'package:flutter/material.dart';

class ThemeSettings extends StatefulWidget{
  @override 
  _ThemeSettingsState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  bool _value = false;

  void _onChanged(bool value){
    setState(() {
      _value = value;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Theme'),
      ),
      body: ListView(
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Dark Theme', style: TextStyle(fontSize: 17)),
                Switch(
                  value: _value,
                  onChanged: (bool value){_onChanged(value);},
                  activeColor: Color.fromRGBO(15, 76, 129, 1),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}