import 'package:flutter/material.dart';

/// 删除的标志位
const String DELETE_FLAG = "delete";
const String POINT_FLAG = "·";

const List<String> keyboardNumberList = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "0"
];
const List<String> keyboardLetterList = [
  "Q",
  "W",
  "E",
  "R",
  "T",
  "Y",
  "U",
  "I",
  "O",
  "P",
  "A",
  "S",
  "D",
  "F",
  "G",
  "H",
  "J",
  "K",
  "L",
  "Z",
  "X",
  "C",
  "V",
  "B",
  "N",
  "M"
];

/// keyboard 整个高度
const double keyboardHeight =
    keyboardItemHeight * 4 + keyboardItemMargin * 2 * 4 + keyboardHeaderHeight;

const double keyboardItemHeight = 38;
const double keyboardItemMargin = 3;
const double keyboardItemTextSize = 16.0;

const double keyboardHeaderHeight = 40;
const double keyboardHeaderButtonTextSize = 16.0;
const double keyboardHeaderTextSize = 14.0;
const double keyboardHeaderConfineSize = 20.0;
const double keyboardHeaderImageSize = 14.0;

const Color keyboardColor = const Color(0xffDCDCDC);
const Color keyboardItemTextColor = const Color(0xff333333);

/// 默认输入的最大长度
const int defaultMaxLangth = 18;
