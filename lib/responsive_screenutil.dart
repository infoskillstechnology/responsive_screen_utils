import 'dart:ui' as ui;
import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveScreenUtil {

  static const Size defaultSize = Size(360, 690);
  static late ResponsiveScreenUtil _instance;

  /// Size of the phone in UI Design , dp
  late Size uiSize;

  /// allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  late bool allowFontScaling;

  static late double _pixelRatio;
  static late double _textScaleFactor;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;

  ResponsiveScreenUtil._();

  factory ResponsiveScreenUtil() {
    return _instance;
  }

  static void init(
      BoxConstraints constraints, {
        Size designSize = defaultSize,
        bool allowFontScaling = false,
      }) {
    _instance = ResponsiveScreenUtil._();
    _instance
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling;
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    var window = WidgetsBinding.instance?.window ?? ui.window;
    _pixelRatio = window.devicePixelRatio;
    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;
    _textScaleFactor = window.textScaleFactor;
  }

  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  double get pixelRatio => _pixelRatio;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  double get screenWidth => _screenWidth;

  ///The vertical extent of this size. dp
  double get screenHeight => _screenHeight;

  /// The offset from the top, in dp
  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  /// The offset from the bottom, in dp
  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  /// The ratio of actual width to UI design
  double get scaleWidth => _screenWidth / uiSize.width;

  ///  /// The ratio of actual height to UI design
  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///Adapt according to the smaller of width or height
  double radius(num r) => r * scaleText;

  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  ///- [allowFontScaling]
  double setSp(num fontSize, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
          ? (fontSize * scaleText) * _textScaleFactor
          : (fontSize * scaleText))
          : (allowFontScalingSelf
          ? (fontSize * scaleText) * _textScaleFactor
          : (fontSize * scaleText));

}