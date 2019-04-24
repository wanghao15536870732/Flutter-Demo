
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/FlutterCalculator/number.dart';
import 'package:flutter_demo/FlutterCalculator/operator.dart';
import 'package:flutter_demo/FlutterCalculator/result.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text( 'Flutter Calculator'),
      ),
      body: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CalculatorState();
}


class CalculatorState extends State<StatefulWidget>{

  List<Result> results = [];
  String currentDisplay = '0'; //屏幕上实时显示的

  onResultButtonPresses(display){
    if(results.length > 0){
      var result = results[results.length - 1];
      if(display == '='){
        result.result  = result.oper.calculate(
          double.parse(result.firstNum),double.parse(result.secondNum)
        );
      }else if(display == 'C'){
        results.removeLast();
      }
    }
    pickCurrentDisplay();
  }

  onOperatorButtonPressed(Operator oper){
    if(results.length > 0){
      var result = results[results.length - 1];  //取最后一个字符
      if(result.result != null){
        var newRes = Result(); //开辟一个新的两数运算
        newRes.firstNum = currentDisplay;  //第一个数字变为屏幕上显示的数字
        newRes.oper = oper;
        results.add(newRes);
      }else if(result.firstNum != null){  //第一个数存在
        result.oper = oper;
      }
    }
    pickCurrentDisplay();
  }

  onNumberButtonPressed(Number number){
    var result = results.length > 0 ? results[results.length - 1] : Result();
    if(result.firstNum == null || result.oper == null){  //第一个字符和运算符均为空
      result.firstNum = number.apply(currentDisplay);   //那第一个字符即为currentDisplay
    }else if(result.result == null) {  //结果为空
      if(result.secondNum == null){ //第二个字符为空
        currentDisplay = '0';  //显示还是为空
      }
      result.secondNum = number.apply(currentDisplay); //现在该输入第二个字符了
    }else{   //开始新的输入了
      var newRes = Result();
      currentDisplay = '0';
      newRes.firstNum = number.apply(currentDisplay);  //将运算好的结果作为第二次运算的第一个字符
      results.add(newRes);  //加入到队列当中
    }
    if(results.length == 0){
      results.add(result);
    }
    pickCurrentDisplay();
  }

  pickCurrentDisplay(){
    this.setState((){
      var display = '0';
      results.removeWhere((item) =>
          item.firstNum == null && item.oper == null && item.secondNum == null
      );
      if(results.length > 0){
        var result = results[results.length - 1]; //获取最后一个字符
        if(result.result != null){
          display = format(result.result);
        }else if(result.secondNum != null && result.oper != null){
          display = result.secondNum;
        }else if(result.firstNum != null){
          display = result.firstNum;
        }
      }
      currentDisplay = display;
    });
  }

  String format(num number){
    if(number == number.toInt()){
      return number.toInt().toString();
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Expanded(
                key: Key('Current Display'),
                flex: 1,
                child: FractionallySizedBox(  //FractionallySizedBox控件会根据现有空间，来调整child的尺寸
                  widthFactor: 1.0,
                  heightFactor: 1,
                  child: Container(
                    color: Colors.lightBlue[300],
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                    child: ResultDisplay(result: currentDisplay)),
                  ),
                ),
              Expanded(
                key: Key('History Display'),
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Container(
                    color: Colors.black54,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      children: results.reversed.map((result){
                        return HistoryBlock(result: result);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                key: Key('Number_button_line_1'),
                child: NumberButtonLine(
                    array: [
                      NormalNumber('1'),
                      NormalNumber('2'),
                      NormalNumber('3'),
                    ],
                  onPress: onNumberButtonPressed,
                ),
                flex: 1,
              ),
              Expanded(
                key: Key('Number_button_line_2'),
                child: NumberButtonLine(
                  array: [
                    NormalNumber('4'),
                    NormalNumber('5'),
                    NormalNumber('6'),
                  ],
                  onPress: onNumberButtonPressed,
                ),
                flex: 1,
              ),
              Expanded(
                key: Key('Number_button_line_3'),
                child: NumberButtonLine(
                  array: [
                    NormalNumber('7'),
                    NormalNumber('8'),
                    NormalNumber('9'),
                  ],
                  onPress: onNumberButtonPressed,
                ),
                flex: 1,
              ),
              Expanded(
                key: Key('Number Button Line 4'),
                child: NumberButtonLine(
                    array: [SymbolNumber(),NormalNumber('0'),DecimalNumber()],
                  onPress: onNumberButtonPressed,
                ),
                flex: 1,
              ),
              Expanded(
                key: Key('Operator Group'),
                child: OperatorGroup(onOperatorButtonPressed),
                flex: 1,
              ),
              Expanded(
                key: Key('Result Button Area'),
                child: Row(
                  children: <Widget>[
                    ResultButton(
                      display: 'C',
                      color: Colors.red,
                      onPress: onResultButtonPresses,
                    ),
                    ResultButton(
                      display: '=',
                      color: Colors.green,
                      onPress: onResultButtonPresses,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}