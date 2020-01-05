import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hypermusicplayer/settings.dart';

enum PlayerState { stopped, playing, paused }

void main() => runApp(HyperMusic());

class HyperMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperMusic',
      //Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: HyperMusicHome(title: 'HyperMusicPlayer'),
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
  MusicFinder audioPlayer;
  IconData iconData = Icons.play_arrow; 
  int _index = 0; 
  PlayerState playerState = PlayerState.stopped;

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  //Player
  void initPlayer() async{
    audioPlayer = new MusicFinder();
    List<Song> songs = await MusicFinder.allSongs();
    songs = new List.from(songs);
    setState(() {
      _songs = songs;
    });
  }

  void stopPlayer() {
    audioPlayer.stop();
  }

  _playLocal(String url) async {
    final result = await audioPlayer.play(url);
    if (result == 1) setState((){
      playerState = PlayerState.playing;
      iconData = Icons.pause;
    });
  } 

  pause() async {
    final result = await audioPlayer.pause();
    setState(() {
      iconData = Icons.play_arrow;
    });
  }  
  
  void _onPressedPlay() {
    setState(() {
      if(iconData == Icons.pause){
        pause();
      }
      if(iconData == Icons.play_arrow){
        _playLocal(_songs[_index].uri);
      }
    });
  }

  //AlbumArt
  dynamic getImage(int idx) {
    if (_songs[idx].albumArt == null) {
      return null;  
    } else {
      return new File.fromUri(Uri.parse(_songs[_index].albumArt));
    }
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
                    width: 500,
                    child: _songs[_index].albumArt != null ? Image.file(File.fromUri(getImage(_index))) : Image.asset('lib/asdf.png')
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0),),
                                      Text(_songs[_index].title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0),),
                                      Text(_songs[_index].artist, style: TextStyle(color: Colors.black)),
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
                          IconButton(icon: Icon(Icons.skip_previous, color: Color.fromRGBO(15, 76, 129, 1),), onPressed: () {
                            setState(() {
                              if (_songs[_index-1] == null) {
                                pause();
                              } else {
                                stopPlayer();
                                _playLocal(_songs[_index-1].uri);
                                _index--;
                              }
                            });
                          }),
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          FloatingActionButton(onPressed: _onPressedPlay, child: Icon(iconData, color: Colors.white,), backgroundColor: Color.fromRGBO(15, 76, 129, 1),),
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          IconButton(icon: Icon(Icons.skip_next, color: Color.fromRGBO(12, 76, 129, 1)), onPressed: () {
                            setState(() {
                              if (_songs[_index+1] == null) {
                                pause();
                              } else{
                                stopPlayer();
                                _playLocal(_songs[_index+1].uri);
                                _index++;
                              }
                            });
                          }),
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
                                        child: Image.asset('lib/AVICI.jpg', width: 100, height: 100,),
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
                                      child: Image.asset('lib/Avicii.jpg', width: 100, height: 100,),
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
                                      child: Image.asset('lib/MartinGarrix.jpg', width: 100, height: 100,),
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
                            Expanded(
                              child: Container(
                                width: 400,
                                child: ListView.builder(
                                  itemCount: _songs.length,
                                  itemBuilder: (context, int index){
                                    return ListTile(
                                      leading: Icon(Icons.more_vert),
                                      title: Text(_songs[index].title),
                                      onTap: () {
                                        stopPlayer();                                       
                                        _index = index;
                                        _playLocal(_songs[index].uri);
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
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