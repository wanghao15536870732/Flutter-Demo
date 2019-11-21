import 'dart:math';
import 'package:flute_music_player/flute_music_player.dart';

class SongData{
  List<Song> _songs;  //歌曲的列表
  int _currentSongIndex = -1;  //当前歌曲下标
  MusicFinder musicFinder;
  SongData(this._songs){
    musicFinder = new MusicFinder();
  }

  List<Song> get songs => _songs;
  int get length => _songs.length;
  int get songNumber => _currentSongIndex + 1;

  setCurrentIndex(int index){
    _currentSongIndex = index;
  }

  int get currentIndex => _currentSongIndex;

  Song get nextSong{
    if(_currentSongIndex < length){
      _currentSongIndex ++;
    }
    if(_currentSongIndex >= length)
      return null;
    return _songs[_currentSongIndex];
  }

  //获取随机的音乐
  Song get randomSong{
    Random r = new Random();
    return _songs[r.nextInt(_songs.length)];
  }

  Song get prevSong{
    if(_currentSongIndex > 0){
      _currentSongIndex --;
    }
    if(_currentSongIndex < 0){
      return null;
    }
    return _songs[_currentSongIndex];
  }
  //获取musicFinder
  MusicFinder get audioPlayer => musicFinder;
}