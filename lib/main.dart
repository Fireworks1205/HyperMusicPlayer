import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/settings.dart';

void main() => runApp(HyperMusic());

class HyperMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperMusic',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
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
  List<Song> _songs;

  @override 
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer() async{
    var songs = await MusicFinder.allSongs();
    songs = new List.from(songs);

    setState(() {
      _songs = songs;
    });
  }

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
                                icon: Icon(Icons.settings,color: Colors.black,), 
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0),),
                                      Text('Heaven', style: TextStyle(color: Colors.black, fontSize: 20)),
                                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0),),
                                      Text('Avicii', style: TextStyle(color: Colors.black)),
                                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),)
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      Container(
                        width: 500,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
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
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            width: 500,
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.skip_previous, color: Color.fromRGBO(15, 76, 129, 1),), onPressed: () {}),
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          FloatingActionButton(onPressed: () {}, child: Icon(Icons.play_arrow, color: Colors.white,), backgroundColor: Color.fromRGBO(15, 76, 129, 1),),
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          IconButton(icon: Icon(Icons.skip_next, color: Color.fromRGBO(12, 76, 129, 1)), onPressed: () {}),
                        ],
                      ),
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
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor ,border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Recent Albums',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
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
                                    Text('AVĪCI (01)', style: TextStyle(fontSize: 16)),
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
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Artists',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
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
                                    Text('Avicii', style: TextStyle(fontSize: 16)),
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
                                    Text('Martin Garrix', style: TextStyle(fontSize: 16)),
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
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Songs',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
                            Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                            Expanded(child: SingleChildScrollView(
                              child: new ListView.builder(
                                itemCount: _songs.length,
                                itemBuilder: (context, int index){
                                  return new ListTile(
                                    leading: new CircleAvatar(
                                      child: new Text(_songs[index].title[0]),
                                    ) ,
                                    title: new Text(_songs[index].title),
                                  );
                                },
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