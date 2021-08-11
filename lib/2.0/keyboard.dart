import 'package:flutter/material.dart';

import 'constant.dart';
import 'letter_keyboard.dart';
import 'number_keyboard.dart';

class Keyboard {
  /// 底部弹出 自定义 字母+数字 键盘  自带下滑消失
  static void showRandomLetterKeyboard({
    required BuildContext context,
    bool isRandomFlag = false,
    int maxValueLength = defaultMaxLength,
    String inputValue = "",
    bool obscureText = false,
    Function(String)? onKeyboardCall,
    bool isThenCall = false,
  }) {
    FocusScope.of(context).requestFocus(FocusNode());

    /// showModalBottomSheet 点击空白地方会消失、showBottomSheet 空白地方不会消失。
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      builder: (BuildContext context) {
        return LetterKeyboard(
          obscureText: obscureText,
          maxValueLength: maxValueLength,
          isRandomFlag: isRandomFlag,
          inputValue: inputValue,
          onKeyboardCall: onKeyboardCall,
          isThenCall: isThenCall,
        );
      },
    );
  }

  /// 底部弹出 自定义 数字 键盘  自带下滑消失
  static void showRandomNumberKeyboard({
    required BuildContext context,
    bool isRandomFlag = false,
    int maxValueLength = defaultMaxLength,
    String inputValue = "",
    bool obscureText = false,
    Function(String)? onKeyboardCall,
    bool isIdNumber = false,
    bool isThenCall = false,
  }) {
    FocusScope.of(context).requestFocus(FocusNode());

    /// showModalBottomSheet 点击空白地方会消失、showBottomSheet 空白地方不会消失。
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      builder: (BuildContext context) {
        return NumberKeyboard(
          obscureText: obscureText,
          maxValueLength: maxValueLength,
          isRandomFlag: isRandomFlag,
          inputValue: inputValue,
          isIdNumber: isIdNumber,
          onKeyboardCall: onKeyboardCall,
          isThenCall: isThenCall,
        );
      },
    );
  }
}
