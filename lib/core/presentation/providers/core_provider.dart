import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:truthordare/core/domain/usecase/truthordare_usecase.dart';
import 'package:truthordare/core/presentation/providers/result_state.dart';
import '../../core.dart';
import '../../domain/entities/dropdown_option_entities.dart';

class CoreProvider with ChangeNotifier {
  final TruthOrDare truthOrDare;

  CoreProvider({required this.truthOrDare});

  TextEditingController _playerNameController = TextEditingController();
  final List<DropdownOption> languageList = [
    DropdownOption(
      title: "English",
      value: "en",
      index: 0,
    ),
    DropdownOption(title: "Indonesia", value: "id", index: 1),
    DropdownOption(title: "Arabic", value: "ar", index: 2),
    DropdownOption(title: "Chinese", value: "zh", index: 3),
    DropdownOption(title: "Danish", value: "da", index: 4),
    DropdownOption(title: "Dutch", value: "nl", index: 5),
    DropdownOption(title: "Finnish", value: "fi", index: 6),
    DropdownOption(title: "French", value: "fr", index: 7),
    DropdownOption(title: "German", value: "de", index: 8),
    DropdownOption(title: "Greek", value: "el", index: 9),
    DropdownOption(title: "Italian", value: "it", index: 10),
    DropdownOption(title: "Japanese", value: "ja", index: 11),
    DropdownOption(title: "Korean", value: "ko", index: 12),
    DropdownOption(title: "Norwegian", value: "no", index: 13),
    DropdownOption(title: "Polish", value: "pl", index: 14),
    DropdownOption(title: "Portuguese", value: "pt", index: 15),
    DropdownOption(title: "Russian", value: "ru", index: 16),
    DropdownOption(title: "Spanish", value: "es", index: 17),
    DropdownOption(title: "Swedish", value: "sv", index: 18),
    DropdownOption(title: "Turkish", value: "tr", index: 19)
  ];
  List<Color> _colorSpin = [
    green,
    lime,
    teal,
    yellow,
    orange,
    red,
    pink,
    purple,
    indigo,
    navy
  ];
  List<String> _playerSpin = [];
  List<SpinItem> _spinItem = [];
  String? _resultPlayer;
  String? _resultTruthOrDare;
  RewardedAd? _rewardedAd;
  RewardedAd? _rewardAd;
  DropdownOption? _language =
      DropdownOption(title: "English", value: "en", index: 0);
  late FocusNode focusNodeAddPlayer = FocusNode();

  set setColorSpin(val) {
    _colorSpin = val;
    notifyListeners();
  }

  set setNameSpin(val) {
    _playerSpin = val;
    notifyListeners();
  }

  set setResultPlayer(val) {
    _resultPlayer = val;
    notifyListeners();
  }

  set setTruthOrDare(val) {
    _resultTruthOrDare = val;
    notifyListeners();
  }

  set setRewardedAd(val) {
    _rewardedAd = val;
    notifyListeners();
  }

  set setRewardAd(val) {
    _rewardAd = val;
    notifyListeners();
  }

  set setLanguage(val) {
    _language = val;
    notifyListeners();
  }

  List<Color> get colorSpint => _colorSpin;
  List<String> get playerSpin => _playerSpin;
  RewardedAd? get rewardedAd => _rewardedAd;
  RewardedAd? get rewardAd => _rewardAd;
  TextEditingController get playerNameController => _playerNameController;
  List<SpinItem> get spinItem => _spinItem;
  String? get resultPlayer => _resultPlayer;
  String? get resultTruthOrDare => _resultTruthOrDare;
  DropdownOption? get language => _language;

  Future<void> addPlayer() async {
    String newPlayer = _playerNameController.text.trim();

    if (newPlayer.isNotEmpty) {
      _playerSpin.add(newPlayer);
      _playerNameController.clear();
    }
  }

  Future<void> removePlayer(int index) async {
    _playerSpin.removeAt(index);
  }

  Color getColor(int index) {
    return _colorSpin[index % _colorSpin.length];
  }

  fetchSpin() {
    _spinItem.clear();

    for (var i = 0; i < _playerSpin.length; i++) {
      int _playerNo = i + 1;
      _spinItem.add(
        SpinItem(
          label: _playerNo.toString(),
          color: getColor(i),
        ),
      );
    }
  }

  Stream<ResultState> fetchTruthOrDare(String type, String lang) async* {
    yield ResultLoading();

    final result = await truthOrDare.call(type, lang);
    yield* result.fold((error) async* {
      yield ResultFailure(error: error);
    }, (res) async* {
      setTruthOrDare = res.data;
      yield ResultSuccess();
    });
  }

  void initializeRewardAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            setRewardAd = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (RewardedAd ad) {
                ad.dispose();
                setRewardedAd = null;
                initializeRewardAd();
              },
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
                ad.dispose();
                initializeRewardAd();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            printWarning('RewardedAd failed to load: $error');
          },
        ));
  }
}
