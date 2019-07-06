import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode = new FocusScopeNode();

  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;

  @override
  Widget build(BuildContext context) {
    return null;
  }


  Widget buildSignInTextForm() {
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white
      ),
      width: 300,
      height: 190,
      child: new Form(
          key: _SignInFormKey,
          child: new Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 20),
                  child: new TextFormField(
                    //关联焦点
                    focusNode: emailFocusNode,
                    onEditingComplete: (){
                      if(focusScopeNode == null){
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(passwordFocusNode);
                    },

                    decoration: new InputDecoration(
                      icon: new Icon(Icons.email,color: Colors.black,),
                      hintText: "Email Address",
                      border: InputBorder.none
                    ),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    //验证
                    validator: (value){
                      if(value.isEmpty){
                        return "Email can noy be empty!";
                      }
                    },
                    onSaved: (value){

                    },
                  ),
                ),
              ),
              new Container(
                height: 1,
                width: 250,
                color: Colors.grey[400],
              ),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25,right: 25,top: 20
                      ),
                    child: new TextFormField(
                      focusNode: passwordFocusNode,
                      decoration: new InputDecoration(
                        icon: new Icon(Icons.lock,color: Colors.black,),
                        hintText: "password",
                        border: InputBorder.none,
                        suffixIcon: new IconButton(
                            icon: new Icon(Icons.remove_red_eye,color: Colors.black,),
                            onPressed: showPassword
                        ),
                      ),
                      obscureText: !isShowPassWord,
                      style: new TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty || value.length < 6){
                          return "Password' length must longer than 6!";
                        }
                      },
                      onSaved: (value){

                      },
                    ),
                  )
              )
            ],
          )
      ),
    );
  }

  void showPassword(){
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  Widget buildSignInButton(){
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}