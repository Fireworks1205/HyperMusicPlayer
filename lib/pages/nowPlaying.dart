import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hypermusicplayer/main.dart';
import 'package:flute_music_player/flute_music_player.dart';

class NowPlaying extends StatefulWidget{
  @override 
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying>{
  MusicFinder audioPlayer;
  List<Song> _songs;
  Duration duration;
  Duration position;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

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

  @override 
  Widget build(BuildContext context){
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body:  SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: screenSize.height/2,
              child: _songs[curIdx].albumArt != null ? Image.file(File.fromUri(Uri.parse(_songs[curIdx].albumArt))) : Image.asset('images/asdf.png')
            ),
            Expanded(
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 10,
                      blurRadius: 30,
                      offset: Offset(0, -2)
                    )
                  ]
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: screenSize.height/15),),
                        Text(_songs[curIdx].title.length < (screenSize.width - 20)/15 ? _songs[curIdx].title : _songs[curIdx].title.substring(0, ((screenSize.width - 20)/15).round()) + "...",  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.only(top: screenSize.height/128),),
                        Text(_songs[curIdx].artist, style: TextStyle(color: Colors.grey),),
                        
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: (screenSize.height - screenSize.width)/16)),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0)
                      ),
                      child: Slider(
                        min: 0,
                        max: _songs[curIdx].duration.toDouble() + 1000,
                        value: position?.inMilliseconds?.toDouble() ?? 0.0,
                        onChanged: (double value) => 
                          audioPlayer.seek((value / 1000).roundToDouble()),
                        divisions: _songs[curIdx].duration,
                        activeColor: Color.fromRGBO(15, 76, 129, 1),
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(position.toString().split('.').first),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text(
                            Duration(milliseconds: _songs[curIdx].duration)
                            .toString()
                            .split('.')
                            .first,
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: (screenSize.height - screenSize.width)/16),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.skip_previous,), onPressed: () {
                          if (_songs[curIdx - 1] == null) {
                            pause();
                          }
                          else{
                            curIdx--;
                            stopPlayer();
                            _playLocal(_songs[curIdx].uri);
                          }
                        },),
                        Padding(padding: EdgeInsets.only(right: 40),),
                        FloatingActionButton(child: Icon(getIcon(), color: Colors.white,), backgroundColor: Color.fromRGBO(15, 76, 129, 1), onPressed: () {_onPressedPlay();},),
                        Padding(padding: EdgeInsets.only(right: 40),),
                        IconButton(icon: Icon(Icons.skip_next,), onPressed: () {
                          if (_songs[curIdx + 1] == null) {
                            pause();
                          }
                          else{
                            curIdx++;
                            stopPlayer();
                            _playLocal(_songs[curIdx].uri);
                          }
                        },)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}