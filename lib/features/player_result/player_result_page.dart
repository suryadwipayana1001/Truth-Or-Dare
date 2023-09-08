import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:truthordare/core/presentation/providers/core_provider.dart';
import 'package:truthordare/features/dare/dare_page.dart';
import 'package:truthordare/features/truth/truth_page.dart';
import '../../core/core.dart';
import '../../core/presentation/providers/loading_provider.dart';
import '../../core/presentation/providers/result_state.dart';

class PlayerResultPage extends StatefulWidget {
  const PlayerResultPage({super.key});
  static const String routeName = '/resultPlayer';

  @override
  State<PlayerResultPage> createState() => _PlayerResultPageState();
}

class _PlayerResultPageState extends State<PlayerResultPage> {
  @override
  Widget build(BuildContext context) {
    final loader = context.read<LoadingProvider>();
    return Scaffold(
      backgroundColor: blue,
      body: Consumer<CoreProvider>(
        builder: (context, provider, _) {
          return context.watch<LoadingProvider>().state
              ? CustomLoading()
              : Container(
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
                              provider
                                  .fetchTruthOrDare(
                                      "truth", provider.language!.value)
                                  .listen(
                                (state) async {
                                  // if (provider.rewardAd == null) {
                                  //   customToast(appLoc.adsWait);
                                  //   provider.initializeRewardAd();
                                  //   return;
                                  // }
                                  // provider.rewardAd!
                                  //     .show(
                                  //         onUserEarnedReward: (AdWithoutView ad,
                                  //             RewardItem rewardItem) {})
                                  //     .then((value) {
                                  switch (state.runtimeType) {
                                    case ResultLoading:
                                      loader.show();
                                      break;
                                    case ResultSuccess:
                                      loader.hide();
                                      Navigator.pushNamed(
                                          context, TruthPage.routeName);
                                      break;
                                    case ResultFailure:
                                      loader.hide();
                                      final error = (state as ResultFailure)
                                          .error
                                          .message;
                                      customToast(error);
                                  }
                                },
                              );
                              //   },
                              // );
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
                              provider
                                  .fetchTruthOrDare(
                                      "dare", provider.language!.value)
                                  .listen((state) async {
                                // if (provider.rewardAd == null) {
                                //   customToast(appLoc.adsWait);
                                //   provider.initializeRewardAd();
                                //   return;
                                // }
                                // provider.rewardAd!
                                //     .show(
                                //         onUserEarnedReward: (AdWithoutView ad,
                                //             RewardItem rewardItem) {})
                                //     .then((value) {
                                switch (state.runtimeType) {
                                  case ResultLoading:
                                    loader.show();
                                    break;
                                  case ResultSuccess:
                                    loader.hide();
                                    Navigator.pushNamed(
                                        context, DarePage.routeName);
                                    break;
                                  case ResultFailure:
                                    loader.hide();
                                    final error =
                                        (state as ResultFailure).error.message;
                                    customToast(error);
                                }
                              });
                              //   },
                              // );
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
