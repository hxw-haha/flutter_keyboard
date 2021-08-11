import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'header_keyboard.dart';
import 'item_keyboard.dart';

class LetterKeyboard extends StatefulWidget {
  /// 是否随机数字
  /// true：随机
  final bool isRandomFlag;

  /// 是否密码
  /// true：是
  final bool obscureText;

  /// 初始化输入的值
  final String inputValue;

  /// 值的长度
  final int maxValueLength;

  /// 是否实时回调
  /// 默认：false：否
  final bool isThenCall;

  final Function(String)? onKeyboardCall;

  const LetterKeyboard(
      {Key? key,
      this.isRandomFlag = false,
      this.obscureText = false,
      this.inputValue = "",
      this.maxValueLength = defaultMaxLength,
      this.isThenCall = false,
      this.onKeyboardCall})
      : super(key: key);

  @override
  _LetterKeyboardState createState() => _LetterKeyboardState();
}

class _LetterKeyboardState extends State<LetterKeyboard> {
  final _headerTextEditingController = TextEditingController();

  /// 数字集合
  final List<String> _keyboardNumberList = [];

  /// 字母集合
  final List<String> _keyboardLetterList = [];

  /// true：大写；false：小写
  bool _stateFlag = false;

  String _value = "";

  /// 更改头部显示的信息
  void _changeHeaderText() {
    _headerTextEditingController.text = _value;
  }

  @override
  void initState() {
    super.initState();
    _value += widget.inputValue;
    _changeHeaderText();

    _keyboardNumberList.clear();
    _keyboardNumberList.addAll(keyboardNumberList);
    if (widget.isRandomFlag) {
      _keyboardNumberList.shuffle();
    }

    _keyboardLetterList.clear();
    _keyboardLetterList.addAll(keyboardLetterList);
    if (widget.isRandomFlag) {
      _keyboardLetterList.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: keyboardHeight,
      decoration: BoxDecoration(
        color: keyboardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(keyboardRadius),
          topRight: Radius.circular(keyboardRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _headerWidget(),
          _rowWidget(_keyboardNumberList),
          _rowWidget(_keyboardLetterList.sublist(0, 10)),
          _rowWidget(_keyboardLetterList.sublist(10, 19)),
          _letterControlRowWidget()
        ],
      ),
    );
  }

  /// 获取 数字、字母 显示的第四行 widget
  Widget _letterControlRowWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ItemChangeKeyboard(
          onChangeCall: (state) {
            _stateFlag = state;
          },
          stateFlag: _stateFlag,
        ),
        _rowWidget(_keyboardLetterList.sublist(19, _keyboardLetterList.length)),
        ItemDeleteKeyboard(
          onDeleteCall: () {
            if (_value.isNotEmpty && _value.length > 0) {
              _value = _value.substring(0, _value.length - 1);
              _changeHeaderText();
              if (widget.isThenCall) {
                widget.onKeyboardCall?.call(_value);
              }
            }
          },
        )
      ],
    );
  }

  Widget _headerWidget() {
    return HeaderKeyboard(
      obscureText: widget.obscureText,
      controller: _headerTextEditingController,
      maxValueLength: widget.maxValueLength,
      onCancelTap: () {
        Navigator.pop(context);
      },
      onClearTap: () {
        _value = "";
        if (widget.isThenCall) {
          widget.onKeyboardCall?.call(_value);
        }
        _changeHeaderText();
      },
      onConfirmTap: () {
        Navigator.pop(context);
        widget.onKeyboardCall?.call(_value);
      },
    );
  }

  /// 获取 一行显示的 widget
  Widget _rowWidget(List<String> list) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((String val) {
        return ItemKeyboard(
          itemValue: val,
          onItemKeyCall: _onItemKeyCall,
          is3_3Board: false,
        );
      }).toList(),
    );
  }

  void _onItemKeyCall(String itemValue) {
    if (_value.length >= widget.maxValueLength) {
      return;
    }
    _value += (_stateFlag ? itemValue.toUpperCase() : itemValue.toLowerCase());
    _changeCall();
  }

  void _changeCall() {
    _changeHeaderText();
    if (widget.isThenCall) {
      widget.onKeyboardCall?.call(_value);
    }
  }

  @override
  void dispose() {
    _keyboardLetterList.clear();
    _keyboardNumberList.clear();
    _headerTextEditingController.dispose();
    super.dispose();
  }
}
