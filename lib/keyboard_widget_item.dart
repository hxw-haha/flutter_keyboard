import 'package:flutter/material.dart';
import '../keyboard/call_back.dart';
import '../keyboard/constant.dart';
import '../keyboard/popup_view.dart';

class KeyboardItemWidget extends StatefulWidget {
  KeyboardItemWidget(
      {Key key,
      this.itemValue = "",
      this.callback,
      this.isMoneyItemFlag = false,
      this.isObscureFlag = false})
      : super(key: key);
  final String itemValue;
  final IKeyboardCallBack callback;

  /// 是否密码  true：密码
  final bool isObscureFlag;

  /// 是否纯数字   true：是
  final bool isMoneyItemFlag;

  @override
  _KeyboardItemWidgetState createState() {
    return new _KeyboardItemWidgetState();
  }
}

class _KeyboardItemWidgetState extends State<KeyboardItemWidget>
    with SingleTickerProviderStateMixin {
  /// item 背景颜色
  bool _isItemColorFlag = true;

  GlobalKey<_KeyboardItemWidgetState> _itemKey = new GlobalKey();

  final PopupView _overlayUtils = PopupView.getInstance();

  /// 切换item 背景显示颜色的状态
  void _changeItemFlag(bool itemFlag) {
    _isItemColorFlag = itemFlag;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth =
        mediaQuery.size.width / (widget.isMoneyItemFlag ? 3 : 10) -
            keyboardItemMargin * 2;
    return GestureDetector(
      onTapDown: (type) {
        _changeItemFlag(false);

        /// 显示信息回调
        if (widget.callback != null) {
          widget.callback.callBack(widget.itemValue);
        }
//        if (!widget.isObscureFlag && !widget.isMoneyItemFlag) {
//          /// 不是密码、且不是纯数字
//          _overlayUtils.show(
//              context: context, message: widget.itemValue, itemKey: _itemKey);
//        }
      },
      onTapUp: (type) {
        _changeItemFlag(true);
      },
      onTapCancel: () {
        _changeItemFlag(true);
      },
      child: Container(
        key: _itemKey,
        decoration: BoxDecoration(
          color: widget.isObscureFlag
              ? Colors.white
              : (_isItemColorFlag ? Colors.white : Colors.grey),
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
    if (widget.itemValue == DELETE_FLAG) {
      return Icon(Icons.backspace);
    } else {
      return Text(
        widget.itemValue,
        style: TextStyle(
            color: keyboardItemTextColor, fontSize: keyboardItemTextSize),
      );
    }
  }
}

/// 删除按钮的 Widget
class KeyboardDeleteWidget extends StatelessWidget {
  final IKeyboardCallBack callback;

  KeyboardDeleteWidget({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width / 10 - keyboardItemMargin * 2;
    return GestureDetector(
      onTapDown: (type) {
        if (callback != null) {
          callback.deleteCall();
        }
      },
      onTap: () {},
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
class KeyboardChangeStateWidget extends StatefulWidget {
  final IKeyboardCallBack callback;
  final bool stateFlag;

  KeyboardChangeStateWidget({Key key, this.callback, this.stateFlag = false})
      : super(key: key);

  @override
  _KeyboardChangeStateWidgetState createState() {
    return new _KeyboardChangeStateWidgetState();
  }
}

class _KeyboardChangeStateWidgetState extends State<KeyboardChangeStateWidget> {
  bool _stateFlag;

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
      onTapDown: (type) {
        _stateFlag = !_stateFlag;
        if (widget.callback != null) {
          widget.callback.changeStateCall(_stateFlag);
        }
      },
      onTap: () {},
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
