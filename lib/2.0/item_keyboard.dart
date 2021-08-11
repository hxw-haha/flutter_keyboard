import 'package:flutter/material.dart';

import 'constant.dart';

class ItemKeyboard extends StatelessWidget {
  final String itemValue;
  final Function(String value)? onItemKeyCall;
  final bool is3_3Board;

  const ItemKeyboard(
      {Key? key,
      this.itemValue = "",
      this.onItemKeyCall,
      this.is3_3Board = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _screenWidth =
        MediaQuery.of(context).size.width / (is3_3Board ? 3 : 10) -
            keyboardItemMargin * 2;
    return GestureDetector(
      onTap: () {
        onItemKeyCall?.call(itemValue);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        alignment: Alignment.center,
        height: keyboardItemHeight,
        margin: EdgeInsets.all(keyboardItemMargin),
        width: _screenWidth,
        child: _getItemWidget(),
      ),
    );
  }

  Widget _getItemWidget() {
    if (itemValue == DELETE_FLAG) {
      return Icon(
        Icons.backspace,
        color: keyboardItemTextColor,
      );
    } else {
      return Text(
        itemValue,
        style: TextStyle(
            color: keyboardItemTextColor, fontSize: keyboardItemTextSize),
      );
    }
  }
}

/// 删除按钮的 Widget
class ItemDeleteKeyboard extends StatelessWidget {
  final Function()? onDeleteCall;

  ItemDeleteKeyboard({Key? key, this.onDeleteCall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width / 10 - keyboardItemMargin * 2;
    return GestureDetector(
      onTap: () {
        onDeleteCall?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        alignment: Alignment.center,
        height: keyboardItemHeight,
        margin: EdgeInsets.all(keyboardItemMargin),
        width: _screenWidth * 1.5,
        child: Icon(Icons.backspace),
      ),
    );
  }
}

/// 切换 大小写 状态的 widget
class ItemChangeKeyboard extends StatefulWidget {
  final Function(bool)? onChangeCall;
  final bool stateFlag;

  ItemChangeKeyboard({Key? key, this.onChangeCall, this.stateFlag = false})
      : super(key: key);

  @override
  _ItemChangeKeyboardState createState() {
    return new _ItemChangeKeyboardState();
  }
}

class _ItemChangeKeyboardState extends State<ItemChangeKeyboard> {
  late bool _stateFlag;

  @override
  void initState() {
    super.initState();
    _stateFlag = widget.stateFlag;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width / 10 - keyboardItemMargin * 2;
    return GestureDetector(
      onTap: () {
        _stateFlag = !_stateFlag;
        widget.onChangeCall?.call(_stateFlag);
        if (mounted) {
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        alignment: Alignment.center,
        height: keyboardItemHeight,
        margin: EdgeInsets.all(keyboardItemMargin),
        width: _screenWidth * 1.5,
        child: Icon(_stateFlag ? Icons.arrow_upward : Icons.arrow_downward),
      ),
    );
  }
}
