import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef void PressOperationCallback(Number number);

//抽象类，以下类用于实现其内部方法
abstract class Number{
  String display;
  String apply(String original);
}

class NormalNumber extends Number{

  NormalNumber(String display){
    this.display = display;
  }

  apply(original) {
    if(original == '0'){
      return display;
    }else{
      return original + display;  //加上接下来所点击的按钮
    }
  }
}

//数字添加正负号
class SymbolNumber extends Number{

  String get display => '+/-';

  @override
  String apply(String original) {
    // TODO: implement apply
    int index = original.indexOf('-');
    if(index == -1 && original != '0'){  //如果原来的式子中没有-
      return '-' + original;  //在前面添加符负号
    }else{
      return original.replaceFirst(new RegExp(r'-'), '');   // RegEx正则表达式，去掉数字串中的'-'号
    }
  }
}

//数字添加.
class DecimalNumber extends Number{
  String get display => '.';
  @override
  String apply(String original) {
    int index = original.indexOf('.');
    if (index == -1) { //original中没有.,即原先的数字当中不包含有.
      return original + '.';
    } else if (index == original.length){ //如果.在该数字的最后，则去掉最后的'.'
      return original.replaceFirst(new RegExp(r'.'), '');
    }else{
      return original;  //其他的直接返回
    }
  }
}


class NumberButtonLine extends StatelessWidget{

  final List<Number> array;
  final PressOperationCallback onPress;

  NumberButtonLine({@required this.array,this.onPress}):assert(array != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        NumberButton(
          number: array[0],
          pad: EdgeInsets.only(bottom: 4.0),
          onPress: onPress,
        ),
        NumberButton(
          number: array[1],
          pad: EdgeInsets.only(left: 4.0,right: 4.0,bottom: 4.0),
          onPress: onPress,
        ),
        NumberButton(
          number: array[2],
          pad: EdgeInsets.only(bottom: 4.0),
          onPress: onPress,
        ),
      ],),
    );
  }
}

class NumberButton extends StatefulWidget{

  const NumberButton({this.number,this.onPress,this.pad})
      :assert(number != null),
        assert(pad != null);
  final Number number;
  final EdgeInsetsGeometry pad;
  final PressOperationCallback onPress;

  @override
  State<StatefulWidget> createState() => new NumberButtonState();
}

class NumberButtonState extends State<NumberButton>{
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,  //这个item占据剩余空间的份数，总数为3
      child: Padding(
          padding: widget.pad,
        child: GestureDetector(
          onTap: (){
            if(widget.onPress != null){
              widget.onPress(widget.number);
              setState(() {
                pressed = true;
              });
              Future.delayed(
                const Duration(milliseconds: 200), //delay200毫秒
              () => setState((){
                pressed = false;
              }));
            }
          },
          child: Container(
            alignment: Alignment.center,
            color: pressed ? Colors.grey[200]:Colors.white,
            child: Text(
              '${widget.number.display}',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
