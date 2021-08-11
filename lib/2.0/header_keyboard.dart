import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class HeaderKeyboard extends StatelessWidget {
  /// 是否密码
  final bool obscureText;

  /// 值的长度
  final int maxValueLength;

  /// 取消
  final GestureTapCallback onCancelTap;

  /// 清理
  final GestureTapCallback onClearTap;

  /// 完成
  final GestureTapCallback onConfirmTap;

  final TextEditingController controller;

  const HeaderKeyboard({
    Key? key,
    required this.obscureText,
    required this.maxValueLength,
    required this.controller,
    required this.onClearTap,
    required this.onConfirmTap,
    required this.onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(keyboardRadius),
          topRight: Radius.circular(keyboardRadius),
        ),
      ),
      alignment: Alignment.center,
      height: keyboardHeaderHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _headerCancelWidget(),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                _headerTextFieldWidget(),
                _headerClearWidget()
              ],
            ),
          ),
          _headerConfirmWidget(),
        ],
      ),
    );
  }

  /// 头部取消
  Widget _headerCancelWidget() {
    return Container(
      padding: EdgeInsets.only(
          right: keyboardHeaderConfineSize, left: keyboardHeaderConfineSize),
      child: GestureDetector(
        onTap: onCancelTap,
        child: Text(
          '取\r\r消',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: keyboardItemTextColor,
            fontSize: keyboardHeaderButtonTextSize,
          ),
        ),
      ),
    );
  }

  /// 头部确认
  Widget _headerConfirmWidget() {
    return Container(
      padding: EdgeInsets.only(
          right: keyboardHeaderConfineSize, left: keyboardHeaderConfineSize),
      child: GestureDetector(
        onTap: onConfirmTap,
        child: Text(
          '确\r\r认',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: keyboardItemTextColor,
            fontSize: keyboardHeaderButtonTextSize,
          ),
        ),
      ),
    );
  }

  /// 头部输入信息
  Widget _headerTextFieldWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        border: Border.all(width: 1, color: keyboardColor),
      ),
      child: TextField(
        //只读
        readOnly: true,
        style: TextStyle(fontSize: 14, color: Colors.black54),
        keyboardType: TextInputType.text,
        obscureText: obscureText,
        inputFormatters: [
          //限制长度
          LengthLimitingTextInputFormatter(maxValueLength)
        ],
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.fromLTRB(6.0, 0, keyboardHeaderHeight, 0.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        controller: controller,
      ),
    );
  }

  /// 头部清除输入信息按钮
  Widget _headerClearWidget() {
    return InkWell(
      onTap: onClearTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: keyboardColor))),
        padding: EdgeInsets.only(
            top: keyboardHeaderImagePadding - 6,
            bottom: keyboardHeaderImagePadding - 6,
            left: keyboardHeaderImagePadding,
            right: keyboardHeaderImagePadding),
        child: ClipOval(
          child: Container(
            color: Colors.grey,
            width: keyboardHeaderImageSize,
            height: keyboardHeaderImageSize,
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: keyboardHeaderImageSize - 4,
            ),
          ),
        ),
      ),
    );
  }
}
