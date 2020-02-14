import 'package:flutter/material.dart';

class MySeparatorVertical extends StatelessWidget {

  final Color color;

  const MySeparatorVertical({this.color = Colors.black}); //初始化color

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints constraints){
        final height = constraints.constrainHeight();  //获取父布局的高度
        final dashWidth = 4.0;  //虚线的宽度
        final dashCount = (height / (2 * dashWidth)).floor();  //floor向下取整
        return Flex(   //Flex组件可以沿着水平或垂直方向排列子组件
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  //布局方式
          direction: Axis.vertical,  //方向
          children: List.generate(dashCount, (_){
            return SizedBox(
              width: 1,
              height: dashWidth,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: color)
              ),
            );
          }),
        );
      },
    );
  }
}