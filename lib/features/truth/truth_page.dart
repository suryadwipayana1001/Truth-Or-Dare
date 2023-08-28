import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../core/presentation/providers/core_provider.dart';

class TruthPage extends StatefulWidget {
  const TruthPage({super.key});
  static const String routeName = '/truth';

  @override
  State<TruthPage> createState() => _TruthPageState();
}

class _TruthPageState extends State<TruthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CoreProvider>(builder: (context, provider, _) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgTruth),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                CustomTitle(
                  title: appLoc.truth,
                  canBack: true,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSizeExtraLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.resultTruthOrDare.toString(),
                          style: whitTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: CustomButton(
                    width: SizeConfig(context).appWidth(75),
                    icon: Image.asset(smileTruth),
                    text: appLoc.playAgain,
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((route) => count++ >= 2);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
