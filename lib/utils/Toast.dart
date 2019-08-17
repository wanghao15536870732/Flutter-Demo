import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toast{
  static OverlayEntry _overlayEntry; //Overlayout
  static bool _showing = false; //toast是否正在showing
  static DateTime _startedTime;   //开启一个新的toast的新的时间
  static String _msg;
  static void toast(BuildContext context, String msg) async{
    assert(msg != null);
    _msg = msg;
    _startedTime = DateTime.now();
    //获取overlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if(_overlayEntry == null){
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
            //top值，可以改变这个值来改变toast在屏幕中的位置
            top: MediaQuery.of(context).size.height * 5 / 6, //当前界面高度的2/3
            child: Container(
              alignment: Alignment.center,  //居中对齐
              width: MediaQuery.of(context).size.width,//获取当前界面的宽度
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0),  //水平方向margin为80.0
                child: AnimatedOpacity(  //淡入淡出动画
                    opacity: _showing ? 1.0 : 0.0,  //当前透明度
                    duration: _showing
                        ? Duration(milliseconds: 100)
                        : Duration(milliseconds: 400),//过度的时间
                    child: _buildToastWidget(),
                ),
              ),
            ),
          )
      );
      overlayState.insert(_overlayEntry);
    }else{
      //重新绘制UI,类似setState
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: 2000));  //等待两秒

    //2秒后 消失
    if(DateTime.now().difference(_startedTime).inMilliseconds >= 2000){
      _showing = false;
      _overlayEntry.markNeedsBuild();
    }
  }
  static _buildToastWidget(){
    return Center(
      child: Card(
        color: Colors.black26,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
          child: Text(
            _msg,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}