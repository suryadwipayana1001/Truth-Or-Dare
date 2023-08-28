import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthordare/core/presentation/providers/core_provider.dart';
import '../../../../core/core.dart';
import '../add_player/add_player_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const String routeName = '/landing';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

final session = locator<Session>();

class _LandingPageState extends State<LandingPage> {
  MySpinController mySpinController = MySpinController();
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
  List<SpinItem> _spinItem = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<CoreProvider>();
      provider.setLanguage = provider.languageList[session.isIndex];
    });
    for (var i = 0; i < _colorSpin.length; i++) {
      _spinItem.add(SpinItem(label: '', color: _colorSpin[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: blue,
      body: Consumer<CoreProvider>(builder: (context, provider, _) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingSizeExtraLarge),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTitle(
                    title: appLoc.appName,
                  ),
                  CustomDropdown(
                    value: provider.languageList[session.isIndex],
                    dropdownList: provider.languageList,
                    title: appLoc.selectLanguage,
                    onChanged: (value) {
                      provider.setLanguage = value;
                      session.setIndexLanguage = value.index;
                    },
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          MySpinner(
                            isSpin: false,
                            mySpinController: mySpinController,
                            wheelSize: 500 * 0.6,
                            itemList: _spinItem,
                            onFinished: (p0) {},
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 3,
                            child: Center(
                              child: Image.asset(
                                roulete,
                                width: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: sizeExtraLarge),
                    child: CustomButton(
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.black,
                      ),
                      text: appLoc.startGame,
                      onPressed: () {
                        provider.initializeRewardAd();
                        Navigator.pushNamed(context, AddPlayerPage.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
