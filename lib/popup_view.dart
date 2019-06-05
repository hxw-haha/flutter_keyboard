import 'package:flutter/material.dart';

class PopupView {
  // 工厂模式
  factory PopupView() => getInstance();

  static PopupView get instance => getInstance();
  static PopupView _instance;
  static List<OverlayEntry> _overlayList;

  PopupView._internal() {
    // 初始化
    _overlayList = new List();
  }

  static PopupView getInstance() {
    if (_instance == null) {
      _instance = PopupView._internal();
    }
    return _instance;
  }

  void show(
      {@required BuildContext context,
      @required String message,
      @required GlobalKey itemKey}) {
    if (_overlayList != null && _overlayList.length > 0) {
      // 当有信息显示时，隐藏所有信息
      cancel();
    }
    //通过 key 获取 widget 位置
    RenderBox renderBox = itemKey.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
          top: offset.dy - size.height - size.height / 4,
          left: offset.dx,
          child: new Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            alignment: Alignment.center,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ));
    });
    Overlay.of(context).insert(overlayEntry);
    _overlayList.add(overlayEntry);
    new Future.delayed(Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
      _overlayList.removeLast();
    });
  }

  void cancel() {
    int len = _overlayList.length - 1;

    ///反向遍历
    for (var i = len; i > -1; --i) {
      _overlayList[i].remove();
    }
    _overlayList.clear();
  }
}
