// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class SizeConfig {
  late BuildContext _context;
  late double _height;
  late double _width;
  late double _heightPadding;
  late double _widthPadding;

  SizeConfig(_context) {
    this._context = _context;
    MediaQueryData queryData = MediaQuery.of(this._context);
    _height = queryData.size.height / 100.0;
    _width = queryData.size.width / 100.0;
    _heightPadding =
        _height - ((queryData.padding.top + queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (queryData.padding.left + queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}
