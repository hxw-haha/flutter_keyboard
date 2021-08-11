# flutter_keyboard

  
 调用方法：
  
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
  

 支持模式：
 
 ![image](https://github.com/hxw-haha/flutter_keyboard/raw/main/支持模式.png)

 模式：字母随机-密码随机
 
 ![image](https://github.com/hxw-haha/flutter_keyboard/raw/main/字母随机-密码随机.png)
  
 模式：数字键盘
 
 ![image](https://github.com/hxw-haha/flutter_keyboard/raw/main/数字键盘.png)
 
 
 实时回调：
 
 ![image](https://github.com/hxw-haha/flutter_keyboard/raw/main/实时回调.png)
