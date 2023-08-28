import 'dart:io';

class AdHelper {
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2976731228725494/6461195160';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/7552160883';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
