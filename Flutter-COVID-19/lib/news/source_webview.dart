import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {

  final String title;
  final String url;
  const WebViewPage({Key key, this.title, this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();
  double lineProgress = 0.0;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onProgressChanged.listen((progress){
      print(progress);
      setState(() {
        lineProgress = progress;
      });
    });
  }

  Widget _progressBar(double progress,BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white,
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[300]),
    );
  }

  @override
  Widget build(BuildContext context) {
    //WebViewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return WebviewScaffold(
      url:this.widget.url, //访问的URL
      appBar: new AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(icon: Icon(Icons.clear,color: Colors.black54), onPressed: (){
          Navigator.pop(context);
        }),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_horiz,color: Colors.black54),
            itemBuilder: (BuildContext context){
              List<PopupMenuEntry> list = List<PopupMenuEntry>();
              list.add(PopupMenuItem(value: '1', child: Text('Item 2')));
              list.add(PopupMenuItem(value: '2', child: Text('Item 3')));
              return list;
            },
            onSelected: (value){
              print(value);
            },
          ),
        ],
        bottom: PreferredSize(
          child: _progressBar(lineProgress,context),
          preferredSize: Size.fromHeight(0.05),
        ),
      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}