import 'dart:convert';
import 'package:demoflutter/EnglishWords/data/translationData.dart';
import 'package:demoflutter/EnglishWords/data/wordData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayer/audioplayer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class WordWidget extends StatefulWidget {

  String word;

  WordWidget(this.word);

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Word Detail',
      theme: new ThemeData(
          primaryColor: Colors.blueAccent
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Word Detail'),

        ),
        body: new Center(
          child: new Text(word),
        ),
      )
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WordState(this.word);
  }
}

class WordState extends State<WordWidget>{

  //当前选中的单词
  String word;
  //当前单词的id
  int code;
  //初始化单词数据解析类
  WordData wordData = WordData.empty();
  //单词例句
  TranslationData samples = TranslationData.empty();
  //音频播放器
  AudioPlayer audioPlayer = new AudioPlayer();
  //音乐播放器状态
  AudioPlayerState playerState;
  //暂停时，音频播放的位置
  Duration position;

  WordState(String word){
    this.word = word;
    _getWordDetail();
  }

  void _getWordDetail() async{
    WordData data = await _fetchWordDetail();
    int wordCode = await _fetchWordCode();
    //Toast.toast(context, wordCode.toString());
    //Toast.toast(context, samples.toString());
    setState(() {
      wordData = data;
      code = wordCode;
    });
    TranslationData samples = await _fetchSamples();
    setState(() {
      this.samples = samples;
    });
  }

  Future<WordData> _fetchWordDetail() async{
    final response = await http.get(
        'http://fanyi.youdao.com/openapi.do?keyfrom=zhaotranslator&key=1681711370&type=data&doctype=json&version=1.1&q='
            + word
    );
    if(response.statusCode == 200){
      return WordData.fromJson(json.decode(response.body));
    }else{
      return WordData.empty();
    }
  }

  Future<int> _fetchWordCode() async{
    final response = await http.get(
      "https://api.shanbay.com/bdc/search/?word=" + word
    );
    Map<String,dynamic> result = json.decode(response.body);
    int code = result['data']['id'];
    return code;
  }

  Future<TranslationData> _fetchSamples() async{
    final response = await http.get(
      "https://api.shanbay.com/bdc/example/?vocabulary_id=" + code.toString() + "&type＝sys"
    );
    if(response.statusCode == 200){
      return TranslationData.fromJson(json.decode(response.body));
    }else{
      return TranslationData.empty();
    }
  }

  void playAudio(String language) async{
    await play(language);
  }

  Future<void> play(String language) async{
    String usAudioUrl = "http://media.shanbay.com/audio/" + language + "/" + word + ".mp3";
    await audioPlayer.play(usAudioUrl);
    setState(() => playerState = AudioPlayerState.PLAYING);
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    setState(() => playerState = AudioPlayerState.PAUSED);
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = AudioPlayerState.STOPPED;
      position = new Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    var content = setData(wordData, word);

    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Translation'),
      ),
      body: content
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  setData(WordData data,String word){

    PanelController panel = new PanelController();

    var translationMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Divider(),
        new Text(
          '翻译结果：' + data.transRes,
          textAlign: TextAlign.left,
          style: new TextStyle(
            fontWeight: FontWeight.bold,fontSize: 18.0
          ),
        ),
        new Divider(),
        new Text('普通发声：' + data.phonetic),
        new Row(
          children: <Widget>[
            new Text('美式发音：' + data.us),
            new IconButton(
              icon: new Icon(
                Icons.surround_sound,
                color: Colors.pinkAccent,
              ),
              onPressed: (){
                playAudio("us");
              },
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new Text('英式发音：' + data.uk),
            new IconButton(
              icon: new Icon(
                Icons.surround_sound,
                color: Colors.blueAccent,
              ),
              onPressed: (){
                playAudio("uk");
              },
            )
          ],
        ),
        new Divider(),
        new Text(
          '翻译解析：',
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.redAccent,
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 15.0),
          child: new Text(
            data.transExp,
            style: new TextStyle(
              fontSize: 14.0,
              color: Colors.redAccent,
            ),
          ),
        ),
        new Divider(),
        new Text('网络翻译：' ),
        new Container(
          margin: EdgeInsets.only(left: 15.0),
          child: new Text(
            data.webs,
            style: new TextStyle(
              fontSize: 14.0,
              color: Colors.redAccent,
            ),
          ),
        ),
        new Divider(),
      ],
    );

    Widget sampleIndex(String first,String word,String last,String translation){
      return new Container(
        margin: EdgeInsets.only(left: 15.0,top: 5.0),
        child: new Text(
          first + " " + word + "" +  last + "\n" + translation,
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
      );
    }

    var translationSamples = samples.annotation.length > 0 ? new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        sampleIndex(samples.firsts[0],this.word,samples.lasts[0], samples.translations[0]),
        new Divider(),
        sampleIndex(samples.firsts[1],this.word,samples.lasts[1], samples.translations[1]),
        new Divider(),
        sampleIndex(samples.firsts[2],this.word,samples.lasts[2], samples.translations[2]),
      ],
    ) : new Text("...");

    return new Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
      child: SlidingUpPanel(
        controller:panel,
        minHeight: 60.0,
        maxHeight: 350.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        collapsed: new Center(
          child: new Text(
            "向上滑动以查看更多",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 18.0,
            ),
          ),
        ),
        body: new Scrollbar(
            child: wordData.webs == "" ? new Center(
              child: new Text(
                "正在加载...",
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ) : new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Container(
                padding: EdgeInsets.only(bottom: 10.0,left: 20.0),
                child: new Column(
                  children: <Widget>[
                    new Text(
                      word,
                      style: new TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                    translationMsg,
                  ],
                ),
              ) ,
            )
        ),
        panel: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 60.0,
              ),
              new Container(
                height: 40.0,
                child: new Center(
                  child: new Text("单词例句",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              translationSamples
            ],
          ),
        ),
      ),
    );
  }
}

