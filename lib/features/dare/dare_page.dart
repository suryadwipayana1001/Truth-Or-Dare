import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthordare/core/core.dart';

import '../../core/presentation/providers/core_provider.dart';
import '../../core/presentation/providers/result_state.dart';

class DarePage extends StatefulWidget {
  const DarePage({super.key});
  static const String routeName = '/dare';

  @override
  State<DarePage> createState() => _DarePageState();
}

class _DarePageState extends State<DarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgDare),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: StreamBuilder<ResultState>(
          stream: context.read<CoreProvider>().fetchTruthOrDare(
              "dare", context.read<CoreProvider>().language!.value),
          builder: (context, state) {
            if (state.hasData) {
              switch (state.data.runtimeType) {
                case ResultLoading:
                  return const Center(child: CustomLoading());
                case ResultSuccess:
                  return Column(
                    children: [
                      CustomTitle(
                        title: appLoc.dare,
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
                                context
                                    .read<CoreProvider>()
                                    .resultTruthOrDare
                                    .toString(),
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
                          icon: Image.asset(smileDare),
                          text: appLoc.playAgain,
                          onPressed: () {
                            int count = 0;
                            Navigator.of(context)
                                .popUntil((route) => count++ >= 2);
                          },
                        ),
                      )
                    ],
                  );
                case ResultFailure:
                  final error = (state as ResultFailure).error.message;
                  customToast(error);
                  return SizedBox();
              }
            }
            return const SizedBox();
          },
        ),
      ),
    ));
  }
}
