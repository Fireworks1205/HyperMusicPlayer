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
  Duration duration;
  Duration position;

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  //Player
  Future initPlayer() async{
    audioPlayer = new MusicFinder();
    List<Song> songs = await MusicFinder.allSongs();
    songs = new List.from(songs);
    setState(() {
      _songs = songs;
    });

    audioPlayer.setDurationHandler((d) => setState(() {
      duration = d;
    }));

    audioPlayer.setPositionHandler((p) => setState(() {
          position = p;
    }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future stopPlayer() async {
    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
        position = new Duration();
      });
  }

  _playLocal(String url) async {
    final result = await audioPlayer.play(url);
    if (result == 1) setState((){
      playerState = PlayerState.playing;
    });
  } 

  pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() {
      playerState = PlayerState.paused;
    });
  }  
  
  void onComplete() {
    stopPlayer();
    setState(() {
      curIdx++;
      if(curIdx >= _songs.length){
        curIdx = 0;
      }
      _playLocal(_songs[curIdx].uri);
    });
  }

  void skipPrevious() {
    if(_songs[curIdx-1] != null){
      curIdx--;
      stopPlayer();
      _playLocal(_songs[curIdx].uri);
    }
    else{
      exit(-1);
    }
  }

  void skipNext(){
    if(_songs[curIdx+1] != null){
      curIdx++;
      stopPlayer();
      _playLocal(_songs[curIdx].uri);
    }
    else{
      exit(-1);
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
    var screenSize = 
        MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
              child:Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Container(
                    width: screenSize.width,
                    height: screenSize.height/2,
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
                                        _songs[curIdx].title.length < (screenSize.width - 20)/15 ? _songs[curIdx].title : _songs[curIdx].title.substring(0, ((screenSize.width - 20)/15).round()) + "...",
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
                        width: screenSize.width,
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
            width: screenSize.width,
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: screenSize.height/256),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.skip_previous, ), onPressed: () {
                            skipPrevious();
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
                            skipNext();
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
                                width: screenSize.width-10,
                                child: ListView.builder(
                                  itemCount: _songs.length,
                                  itemBuilder: (context, int index){
                                    return ListTile(
                                      leading: Icon(Icons.more_vert),
                                      title: Text(_songs[index].title.length < (screenSize.width - 20)/6 ? _songs[index].title : _songs[index].title.substring(0, ((screenSize.width - 20)/6).round()) + "..."),
                                      onTap: () {
                                        curIdx = index;
                                        stopPlayer();
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