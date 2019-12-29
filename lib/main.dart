import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hypermusicplayer/settings.dart';

void main() => runApp(HyperMusic());

class HyperMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: HyperMusicHome(title: 'Flutter Demo Home Page'),
    );
  }
}

class HyperMusicHome extends StatefulWidget {
  HyperMusicHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HyperMusicHomeState createState() => _HyperMusicHomeState();
}

class _HyperMusicHomeState extends State<HyperMusicHome> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
              child:Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Container(
                    child: Image.asset('lib/Tim.jpg'),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                icon: Icon(Icons.settings), 
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Settings())
                                  );
                                }
                              )
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(icon: Icon(Icons.search), onPressed: () {})
                          ),
                        ],
                      ),

                      Container(
                        width: 500,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 10,
                                blurRadius: 20,
                                offset: Offset(0, -7)
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
          Container(
            width: 500,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.skip_previous, color: Color.fromRGBO(15, 76, 129, 1),), onPressed: () {}),
                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      FloatingActionButton(onPressed: () {}, child: Icon(Icons.play_arrow, color: Colors.white,), backgroundColor: Color.fromRGBO(15, 76, 129, 1),),
                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      IconButton(icon: Icon(Icons.skip_next, color: Color.fromRGBO(12, 76, 129, 1)), onPressed: () {}),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20))
              ],
            ),
          ),
          Expanded(
              child: PageView(
                controller: controller,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Recent Albums',style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
                            Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.asset('lib/AVICI.jpg', width: 150, height: 150,),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(bottom: 10)),
                                    Text('AVĪCI (01)', style: TextStyle(fontSize: 16, color: Colors.black)),
                                    Text('Avicii', style: TextStyle(fontSize: 14, color: Colors.grey),)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Artists',style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
                            Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset('lib/Avicii.jpg', width: 150, height: 150,),
                                    ),
                                    Padding(padding: EdgeInsets.only(bottom: 10)),
                                    Text('Avicii', style: TextStyle(fontSize: 16, color: Colors.black)),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset('lib/MartinGarrix.jpg', width: 150, height: 150,),
                                    ),
                                    Padding(padding: EdgeInsets.only(bottom: 10)),
                                    Text('Martin Garrix', style: TextStyle(fontSize: 16, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Songs',style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
                            Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                            Expanded(child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                                      Text('Without You', style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                                      Text('Heaven', style: TextStyle(fontSize: 20),)
                                    ],
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
