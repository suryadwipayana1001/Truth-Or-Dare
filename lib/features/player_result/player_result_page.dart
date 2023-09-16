import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:truthordare/core/presentation/providers/core_provider.dart';
import 'package:truthordare/features/dare/dare_page.dart';
import 'package:truthordare/features/truth/truth_page.dart';
import '../../core/core.dart';
import '../../core/presentation/providers/loading_provider.dart';

class PlayerResultPage extends StatefulWidget {
  const PlayerResultPage({super.key});
  static const String routeName = '/resultPlayer';

  @override
  State<PlayerResultPage> createState() => _PlayerResultPageState();
}

class _PlayerResultPageState extends State<PlayerResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CoreProvider>().initializeRewardAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Consumer<CoreProvider>(
        builder: (context, provider, _) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgOption),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (provider.rewardAd == null &&
                            (provider.adsFailed == false)) {
                          customToast(appLoc.adsWait);
                          provider.initializeRewardAd();
                          return;
                        } else if (provider.adsFailed == true) {
                          Navigator.pushNamed(context, TruthPage.routeName);
                        } else {
                          provider.rewardAd!
                              .show(
                                  onUserEarnedReward: (AdWithoutView ad,
                                      RewardItem rewardItem) {})
                              .then(
                            (value) {
                              Navigator.pushNamed(context, TruthPage.routeName);
                            },
                          );
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: SizeConfig(context).appWidth(100),
                        height: SizeConfig(context).appHeight(100),
                        child: Center(
                          child: Text(
                            appLoc.truth + " !",
                            style: optionTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSizeExtraLarge),
                    child: Container(
                      width: SizeConfig(context).appWidth(100),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(sizeSmall),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSizeLarge,
                            vertical: paddingsizeMedium),
                        child: Center(
                          child: Text(
                            provider.resultPlayer.toString(),
                            style: playerTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (provider.rewardAd == null &&
                            (provider.adsFailed == false)) {
                          customToast(appLoc.adsWait);
                          provider.initializeRewardAd();
                          return;
                        } else if (provider.adsFailed == true) {
                          Navigator.pushNamed(context, DarePage.routeName);
                        } else {
                          provider.rewardAd!
                              .show(
                                  onUserEarnedReward: (AdWithoutView ad,
                                      RewardItem rewardItem) {})
                              .then(
                            (value) {
                              Navigator.pushNamed(context, DarePage.routeName);
                            },
                          );
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: SizeConfig(context).appWidth(100),
                        height: SizeConfig(context).appHeight(100),
                        child: Center(
                          child: Text(
                            appLoc.dare + " !",
                            style: optionTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
