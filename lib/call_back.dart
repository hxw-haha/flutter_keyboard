/// 点击成功的回调事件
abstract class ISucceedCallBack {
//  void onStart(double keyboardHeight);
  void onSucceed(String value);
//  void onFinish(double keyboardHeight);
}

/// keyboard 自身回调事件
abstract class IKeyboardCallBack {
  /// 值的回调
  void callBack(String value);

  /// 删除
  void deleteCall();

  /// state:true 大写；false 小写
  void changeStateCall(bool state);
}
