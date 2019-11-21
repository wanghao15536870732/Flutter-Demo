import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MoviePlay extends StatefulWidget{

  final String videoUrl;
  const MoviePlay({Key key, this.videoUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MoviePlayState(videoUrl);
  }
}

class MoviePlayState extends State<MoviePlay> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  String videoUrl;

  MoviePlayState(String videoUrl){
    this.videoUrl = videoUrl;
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(this.videoUrl)
    // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() { _isPlaying = isPlaying; });
        }
      })
      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    //资源进行释放
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoPlay: !true,
      looping: true,
      showControls: true,
      // 占位图
      placeholder: new Container(
        color: Colors.grey,
      ),

      // 是否在 UI 构建的时候就加载视频
      autoInitialize: true,

      // 拖动条样式颜色
      materialProgressColors: new ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text("视频播放"),
      ),
      body:
      new Center(
        child: new Chewie(
          controller: chewieController,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _controller.value.isPlaying
              ? _controller.pause
              : _controller.play,
        child: new Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
