import 'package:flutter/material.dart';

/// keyboard 整个高度
const double keyboardHeight =
    keyboardItemHeight * 4 + keyboardItemMargin * 2 * 4 + keyboardHeaderHeight;

const double keyboardHeaderHeight = 40;
const double keyboardHeaderButtonTextSize = 16.0;
const double keyboardHeaderTextSize = 14.0;
const double keyboardHeaderConfineSize = 10.0;
const double keyboardHeaderImageSize = 16.0;
const double keyboardHeaderImagePadding =
    (keyboardHeaderHeight - keyboardHeaderImageSize) / 2;

const double keyboardItemHeight = 38;
const double keyboardItemMargin = 3;
const double keyboardItemTextSize = 16.0;
const double keyboardRadius = 10;

/// 默认输入的最大长度
const int defaultMaxLength = 18;

const Color keyboardColor = const Color(0xffDCDCDC);
const Color keyboardItemTextColor = const Color(0xff333333);

const String ITEM_X = "X";
const String POINT_FLAG = "·";
const String DELETE_FLAG = "delete";

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
