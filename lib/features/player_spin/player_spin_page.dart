import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthordare/core/core.dart';
import 'package:truthordare/features/player_result/player_result_page.dart';

import '../../core/presentation/providers/core_provider.dart';

class PlayerSpinPage extends StatefulWidget {
  const PlayerSpinPage({super.key});
  static const String routeName = '/playerSpin';

  @override
  State<PlayerSpinPage> createState() => _PlayerSpinState();
}

class _PlayerSpinState extends State<PlayerSpinPage> {
  MySpinController mySpinController = MySpinController();

  @override
  void initState() {
    super.initState();
    context.read<CoreProvider>().fetchSpin();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: blue,
        body: SafeArea(
          child: Column(
            children: [
              CustomTitle(
                title: appLoc.truthOrDare,
                canBack: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: 370,
                    height: 370,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          MySpinner(
                            isSpin: true,
                            mySpinController: mySpinController,
                            wheelSize: 500,
                            itemList: provider.spinItem,
                            onFinished: (p0) {
                              printError("text");
                            },
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 3,
                            child: Center(
                              child: Image.asset(
                                roulete,
                                width: 125,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 3,
                            child: Center(
                              child: Image.asset(
                                circle,
                                width: 370,
                                height: 370,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: paddingSizeExtraLarge,
                    left: paddingSizeExtraLarge,
                    bottom: 100.0),
                child: CustomButton(
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.black,
                  ),
                  text: appLoc.spinNow,
                  onPressed: () async {
                    int rdm = Random().nextInt(provider.spinItem.length);
                    await mySpinController.spinNow(
                      luckyIndex: rdm + 1,
                      totalSpin: provider.spinItem.length,
                      baseSpinDuration: 500,
                    );
                    provider.setResultPlayer = provider.playerSpin[rdm];
                    Future.delayed(Duration(milliseconds: 700), () {
                      Navigator.pushNamed(context, PlayerResultPage.routeName);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
