import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core.dart';

late AppLocalizations appLoc;

Widget smallVerticalSpacing() => const SizedBox(height: verticalSpaceSM);
Widget mediumVerticalSpacing() => const SizedBox(height: verticalSpaceMD);
Widget largeVerticalSpacing() => const SizedBox(height: verticalSpaceLG);
Widget smallHorizontalSpacing() => const SizedBox(width: verticalSpaceSM);
Widget mediumHorizontalSpacing() => const SizedBox(width: verticalSpaceMD);
Widget largeHorizontalSpacing() => const SizedBox(width: verticalSpaceLG);
Widget extraLargeVerticalSpacing() =>
    const SizedBox(height: verticalSpaceExtraLG);

logMe(Object? obj, {String tag = 'log'}) {
  if (kDebugMode) {
    print('$tag :$obj');
  }
}

void printWarning(dynamic text) {
  // ignore: avoid_print
  print('\x1B[33m$text\x1B[0m');
}

void printError(dynamic text) {
  // ignore: avoid_print
  print('\x1B[31m$text\x1B[0m');
}

class MaxWordTextInputFormater extends TextInputFormatter {
  final int maxWords;
  final ValueChanged<int>? currentLength;

  MaxWordTextInputFormater({this.maxWords = 1, this.currentLength});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int count = 0;
    if (newValue.text.isEmpty) {
      count = 0;
    } else {
      count = newValue.text.trim().split(RegExp(r'[ \s]+')).length;
    }
    if (count > maxWords) {
      return oldValue;
    }
    currentLength?.call(count);
    return newValue;
  }
}

void customToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 1,
    backgroundColor: white,
    textColor: red,
  );
}
