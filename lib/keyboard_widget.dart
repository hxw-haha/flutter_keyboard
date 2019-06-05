import 'package:flutter/material.dart';
import '../keyboard/call_back.dart';
import '../keyboard/constant.dart';
import '../keyboard/keyboard_widget_item.dart';

/// 底部弹出 自定义键盘  自带下滑消失
void showRandomKeyboardWidget(
  GlobalKey<ScaffoldState> scaffoldKey, {
  @required BuildContext context,
  ISucceedCallBack callback,
  bool isNumberRandomFlag = false,
  bool isLetterRandomFlag = false,
  bool isClickCallFlag = true,
  bool isObscureTextFlag = false,
  bool isMoneyItemFlag = false,
  int valueLength = defaultMaxLangth,
  String inputValue = "",
}) {
//  if (callback != null) {
//    callback.onStart(keyboardHeight);
//  }

  /// 更改 _ModalBottomSheetRoute 类中 Color get barrierColor => const Color(0x01000000);
  ///  showModalBottomSheet  点击空白地方会消失
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return RandomKeyboardWidget(
        callback: callback,
        isNumberRandomFlag: isNumberRandomFlag,
        isLetterRandomFlag: isLetterRandomFlag,
        isClickCallFlag: isClickCallFlag,
        isObscureTextFlag: isObscureTextFlag,
        isMoneyItemFlag: isMoneyItemFlag,
        valueLength: valueLength,
        inputValue: inputValue,
      );
    },
  ).then((result) {
    print("回掉了");
//    if (callback != null) {
//      callback.onFinish(keyboardHeight);
//    }
  });

  /// showBottomSheet 点击空白地方不会消失
//  scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
//    return RandomKeyboardWidget(
//      callback: callback,
//      isNumberRandomFlag: isNumberRandomFlag,
//      isLetterRandomFlag: isLetterRandomFlag,
//      isClickCallFlag: isClickCallFlag,
//      isObscureTextFlag: isObscureTextFlag,
//      isMoneyItemFlag: isMoneyItemFlag,
//      valueLength: valueLength,
//      inputValue: inputValue,
//    );
//  });
}

class RandomKeyboardWidget extends StatefulWidget {
  final ISucceedCallBack callback;

  /// 数字是否随机：true 随机
  final bool isNumberRandomFlag;

  /// 字符是否随机：true 随机
  final bool isLetterRandomFlag;

  /// 是否点击回调并返回数据：true 返回
  final bool isClickCallFlag;

  /// 是否是密码
  final bool isObscureTextFlag;

  /// 是否显示金额的 item
  final bool isMoneyItemFlag;

  /// 值的长度
  final int valueLength;

  /// 初始化输入的值
  final String inputValue;

  RandomKeyboardWidget({
    Key key,
    this.callback,
    this.isNumberRandomFlag = false,
    this.isLetterRandomFlag = false,
    this.isClickCallFlag = true,
    this.isObscureTextFlag = false,
    this.isMoneyItemFlag = false,
    this.valueLength = defaultMaxLangth,
    this.inputValue = "",
  }) : super(key: key);

  @override
  _RandomKeyboardWidgetState createState() {
    return new _RandomKeyboardWidgetState();
  }
}

class _RandomKeyboardWidgetState extends State<RandomKeyboardWidget>
    implements IKeyboardCallBack {
  /// 输入框的监听事件
  final _headerTextEditingController = TextEditingController();

  String _value = "";

  /// true：大写；false：小写
  bool _stateFlag = false;

  /// 数字集合
  List<String> _keyboardNumberList = new List();

  /// 字母集合
  List<String> _keyboardLetterList = new List();

  /// 更改头部显示的信息
  void _changeHeaderText() {
    _headerTextEditingController.text = _value;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _headerTextEditingController.dispose();

    if (_keyboardNumberList != null) {
      _keyboardNumberList.clear();
      _keyboardNumberList = null;
    }

    if (_keyboardLetterList != null) {
      _keyboardLetterList.clear();
      _keyboardLetterList = null;
    }
  }

  @override
  void initState() {
    super.initState();

    _value += (widget.inputValue ?? "");
    _changeHeaderText();

    _keyboardNumberList.clear();
    _keyboardNumberList.addAll(keyboardNumberList);
    if (widget.isNumberRandomFlag) {
      _keyboardNumberList.shuffle();
    }

    _keyboardLetterList.clear();
    _keyboardLetterList.addAll(keyboardLetterList);
    if (widget.isLetterRandomFlag) {
      _keyboardLetterList.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: keyboardColor,
      height: keyboardHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getKeyboardWidgetList(),
      ),
    );
  }

  List<Widget> _getKeyboardWidgetList() {
    List<Widget> keyboardList = new List();
    keyboardList.add(_getHeaderWidget());
    if (widget.isMoneyItemFlag) {
      keyboardList.add(_getRowWidget(_keyboardNumberList.sublist(0, 3)));
      keyboardList.add(_getRowWidget(_keyboardNumberList.sublist(3, 6)));
      keyboardList.add(_getRowWidget(_keyboardNumberList.sublist(6, 9)));
      keyboardList.add(_getNumberControlRowWidget());
    } else {
      keyboardList.add(_getRowWidget(_keyboardNumberList));
      keyboardList.add(_getRowWidget(_keyboardLetterList.sublist(0, 10)));
      keyboardList.add(_getRowWidget(_keyboardLetterList.sublist(10, 19)));
      keyboardList.add(_getControlRowWidget());
    }
    return keyboardList;
  }

  /// 获取 数字 显示的第四行 widget
  Widget _getNumberControlRowWidget() {
    List<Widget> numberControlWidget = new List();
    numberControlWidget.add(_getKeyboardItemWidget(POINT_FLAG));
    numberControlWidget.add(_getRowWidget(
        _keyboardNumberList.sublist(9, _keyboardNumberList.length)));
    numberControlWidget.add(_getKeyboardItemWidget(DELETE_FLAG));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: numberControlWidget,
    );
  }

  /// 获取 数字、字母 显示的第四行 widget
  Widget _getControlRowWidget() {
    List<Widget> controlWidget = new List();
    controlWidget.add(KeyboardChangeStateWidget(
      callback: this,
      stateFlag: _stateFlag,
    ));
    controlWidget.add(_getRowWidget(
        _keyboardLetterList.sublist(19, _keyboardLetterList.length)));
    controlWidget.add(KeyboardDeleteWidget(
      callback: this,
    ));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: controlWidget,
    );
  }

  /// 获取 一行显示的 widget
  Widget _getRowWidget(List<String> list) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((String val) {
        return _getKeyboardItemWidget(val);
      }).toList(),
    );
  }

  /// 获取 keyboard item widget
  /// {itemValue}:显示的值
  Widget _getKeyboardItemWidget(String itemValue) {
    return KeyboardItemWidget(
      itemValue: itemValue,
      callback: this,
      isMoneyItemFlag: widget.isMoneyItemFlag,
      isObscureFlag: widget.isObscureTextFlag,
    );
  }

  /// 头部 widget
  Widget _getHeaderWidget() {
    return Container(
      alignment: Alignment.center,
      height: keyboardHeaderHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                right: keyboardHeaderConfineSize,
                left: keyboardHeaderConfineSize),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                _value = "";
                _changeHeaderText();
                if (widget.callback != null) {
                  widget.callback.onSucceed(_value);
                }
              },
              child: Text(
                '取  消',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: keyboardHeaderButtonTextSize,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              enabled: false,
              keyboardType: TextInputType.text,
              obscureText: widget.isObscureTextFlag ?? false,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.fromLTRB(6.0, 4.0, 0.0, 4.0), //设置显示文本的一个内边距
              ),
              controller: _headerTextEditingController,
            ),
          ),
          Offstage(
            offstage: _value.length > 0 ? false : true,
            child: InkWell(
              onTap: () {
                _value = "";
                _changeHeaderText();
                if (widget.callback != null) {
                  widget.callback.onSucceed(_value);
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: (keyboardHeaderHeight - keyboardHeaderImageSize) / 2,
                    bottom:
                        (keyboardHeaderHeight - keyboardHeaderImageSize) / 2),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: keyboardHeaderImageSize,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                right: keyboardHeaderConfineSize,
                left: keyboardHeaderConfineSize),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                if (widget.callback != null) {
                  widget.callback.onSucceed(_value);
                }
              },
              child: Text(
                '完  成',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: keyboardHeaderButtonTextSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void callBack(String value) {
    if (value == POINT_FLAG) {
      if (_value.length >= widget.valueLength ?? defaultMaxLangth) {
        return;
      }
      _value += ".";
    } else if (value == DELETE_FLAG) {
      if (_value.length > 0) {
        _value = _value.substring(0, _value.length - 1);
      }
    } else {
      if (_value.length >= widget.valueLength ?? 16) {
        return;
      }
      _value += (_stateFlag ? value.toUpperCase() : value.toLowerCase());
    }
    _changeHeaderText();
    if (widget.isClickCallFlag && widget.callback != null) {
      widget.callback.onSucceed(_value);
    }
  }

  @override
  void changeStateCall(bool state) {
    setState(() {
      _stateFlag = state;
    });
  }

  @override
  void deleteCall() {
    if (_value.length > 0) {
      _value = _value.substring(0, _value.length - 1);
      _changeHeaderText();
      if (widget.isClickCallFlag && widget.callback != null) {
        widget.callback.onSucceed(_value);
      }
    }
  }
}
