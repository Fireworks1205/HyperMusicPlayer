import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hypermusicplayer/pages/nowPlaying.dart';
import 'package:hypermusicplayer/pages/settings.dart';
import 'package:hypermusicplayer/views/albums.dart';
import 'package:hypermusicplayer/views/artists.dart';

void main() => runApp(HyperMusic());

enum PlayerState { stopped, playing, paused }
PlayerState playerState = PlayerState.stopped;
IconData iconData = Icons.play_arrow;  
int curIdx = 0;

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
  MusicFinder audioPlayer;
  List<Song> _songs;
  IconData iconData = Icons.play_arrow;    

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
    playerState = PlayerState.stopped;
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
    if (result == 1) {
      setState(() {
        playerState = PlayerState.paused;
      });
    }
  }  
  
  void _onPressedPlay() {
    setState(() {
      if(playerState == PlayerState.playing){
        pause();
      }
      else {
        _playLocal(_songs[curIdx].uri);
      }
    });
  }

  //AlbumArt
  dynamic getImage(int idx) {
    if (_songs[idx].albumArt == null) {
      return null;  
    } else {
      return new File.fromUri(Uri.parse(_songs[curIdx].albumArt));
    }
  }

  IconData getIcon(){
    if (playerState == PlayerState.playing) {
      return Icons.pause;
    }
    else{
      return Icons.play_arrow;
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
                    child: GestureDetector(
                      child: _songs[curIdx].albumArt != null ? Image.file(File.fromUri(getImage(curIdx))) : Image.asset('images/asdf.png'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NowPlaying()
                          )
                        );
                      },
                    )
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
                                      Text(
                                        _songs[curIdx].title.length < 34 ? _songs[curIdx].title : _songs[curIdx].title.substring(0, 31) + "...",
                                       style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0),),
                                      Text(_songs[curIdx].artist, style: TextStyle(color: Colors.black)),
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
                                blurRadius: 30,
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
                          IconButton(icon: Icon(Icons.skip_previous, ), onPressed: () {
                            setState(() {
                              if (_songs[curIdx-1] == null) {
                                pause();
                              } else {
                                stopPlayer();
                                _playLocal(_songs[curIdx-1].uri);
                                curIdx--;
                              }
                            });
                          }),
                          Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                          FloatingActionButton(
                            onPressed: _onPressedPlay,
                            child: Icon(
                              getIcon(), 
                              color: Colors.white,
                            ), 
                            backgroundColor: Color.fromRGBO(15, 76, 129, 1),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                          IconButton(icon: Icon(Icons.skip_next,), onPressed: () {
                            setState(() {
                              if (_songs[curIdx+1] == null) {
                                pause();
                              } else{
                                stopPlayer();
                                _playLocal(_songs[curIdx+1].uri);
                                curIdx++;
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
                  AlbumView(),
                  Artists(),
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
                                        curIdx = index;
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