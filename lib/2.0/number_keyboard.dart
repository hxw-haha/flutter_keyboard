import 'package:flutter/material.dart';

import 'constant.dart';
import 'header_keyboard.dart';
import 'item_keyboard.dart';

class NumberKeyboard extends StatefulWidget {
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
  /// 默认：true：是
  final bool isThenCall;

  /// 是否身份证证件号键盘
  /// 默认：false：否
  final bool isIdNumber;

  final Function(String)? onKeyboardCall;

  const NumberKeyboard(
      {Key? key,
      this.isRandomFlag = false,
      this.inputValue = "",
      this.maxValueLength = defaultMaxLength,
      this.onKeyboardCall,
      this.obscureText = false,
      this.isThenCall = true,
      this.isIdNumber = true})
      : super(key: key);

  @override
  _NumberKeyboardState createState() => _NumberKeyboardState();
}

class _NumberKeyboardState extends State<NumberKeyboard> {
  final List<String> _keyboardNumberList = [];
  String _value = "";
  final _headerTextEditingController = TextEditingController();

  /// 更改头部显示的信息
  void _changeHeaderText() {
    _headerTextEditingController.text = _value;
  }

  @override
  void dispose() {
    super.dispose();
    if (_keyboardNumberList != null) {
      _keyboardNumberList.clear();
    }

    if (_headerTextEditingController != null) {
      _headerTextEditingController.dispose();
    }
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
          _rowWidget(_keyboardNumberList.sublist(0, 3)),
          _rowWidget(_keyboardNumberList.sublist(3, 6)),
          _rowWidget(_keyboardNumberList.sublist(6, 9)),
          _numberControlRowWidget()
        ],
      ),
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

  /// 获取 数字 显示的第四行 widget
  Widget _numberControlRowWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _keyboardItemWidget(widget.isIdNumber ? ITEM_X : POINT_FLAG),
        _rowWidget(_keyboardNumberList.sublist(9, _keyboardNumberList.length)),
        _keyboardItemWidget(DELETE_FLAG),
      ],
    );
  }

  /// 获取 一行显示的 widget
  Widget _rowWidget(List<String> list) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((String val) {
        return _keyboardItemWidget(val);
      }).toList(),
    );
  }

  /// 获取 keyboard item widget
  /// {itemValue}:显示的值
  Widget _keyboardItemWidget(String itemValue) {
    return ItemKeyboard(
      itemValue: itemValue,
      onItemKeyCall: _onItemKeyCall,
      is3_3Board: true,
    );
  }

  void _onItemKeyCall(String itemValue) {
    if (itemValue == DELETE_FLAG) {
      ///删除键
      if (_value.length > 0) {
        _value = _value.substring(0, _value.length - 1);
        _changeCall();
      }
      return;
    }

    if (_value.length >= widget.maxValueLength) {
      ///输入长度不能超出
      return;
    }

    if (!widget.isIdNumber) {
      /// 数字键盘类型
      if (_value.length == 0 && itemValue == "0") {
        /// 当第一个数字为0，自动为后面拼接'.'
        _value = itemValue + '.';
        _changeCall();
        return;
      }
    } else {
      /// 身份证键盘类型
      if ((_value.length == 0 && itemValue == "0") ||
          (_value.length > defaultMaxLength - 4 && _value.contains(ITEM_X))) {
        /// 1.第一个数字不能为0
        /// 2.当大于defaultMaxLength - 4即15位且包含了X，不让后面输入
        return;
      }
    }

    if (itemValue == POINT_FLAG) {
      if (_value.contains(".") ||
          _value.length == 0 ||
          _value.length == widget.maxValueLength - 1) {
        ///1.不能重复输入"."
        ///2.第一个不能输入"."
        ///3.最后一个不能输入"."
        return;
      }
      itemValue = ".";
    } else if (itemValue == ITEM_X) {
      if (_value.contains(ITEM_X) || _value.length < defaultMaxLength - 4) {
        ///1.不能重复输入"X"
        ///2.小于defaultMaxLength(18-4=14)不能输入X，适配15位身份证
        return;
      }
    }
    _value += itemValue;

    _changeCall();
  }

  void _changeCall() {
    _changeHeaderText();
    if (widget.isThenCall) {
      widget.onKeyboardCall?.call(_value);
    }
  }
}
