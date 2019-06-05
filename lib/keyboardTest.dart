import 'package:flutter/material.dart';
import '../keyboard/call_back.dart';
import '../keyboard/keyboard_widget.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> implements ISucceedCallBack {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String textValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("keyBoard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textValue,
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                  isObscureTextFlag: true,
                );
              },
              child: Text("密码-弹出字母+数字键盘"),
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                );
              },
              child: Text("弹出字母+数字键盘"),
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                  isLetterRandomFlag: true,
                );
              },
              child: Text("弹出随机字母+数字键盘"),
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                  isNumberRandomFlag: true,
                );
              },
              child: Text("弹出字母+随机数字键盘"),
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                  isNumberRandomFlag: true,
                  isLetterRandomFlag: true,
                );
              },
              child: Text("弹出随机字母+随机数字键盘"),
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                  isMoneyItemFlag: true,
                );
              },
              child: Text("数字键盘"),
            ),
            RaisedButton(
              onPressed: () {
                showRandomKeyboardWidget(
                  _scaffoldKey,
                  context: context,
                  callback: this,
                  inputValue: textValue,
                  isMoneyItemFlag: true,
                  isNumberRandomFlag: true,
                );
              },
              child: Text("随机数字键盘"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onSucceed(String value) {
    textValue = value;
    setState(() {});
  }
}
