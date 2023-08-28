import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthordare/core/presentation/widgets/custom_textfield.dart';
import '../../core/core.dart';
import '../../core/presentation/providers/core_provider.dart';
import '../player_spin/player_spin_page.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({super.key});
  static const String routeName = '/addPlayer';

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => provider.focusNodeAddPlayer.unfocus(),
          child: Scaffold(
            backgroundColor: blue,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTitle(
                      title: appLoc.addPlayer,
                      canBack: true,
                    ),
                    Padding(
                      padding: EdgeInsets.all(paddingSizeExtraLarge),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    focusNode: provider.focusNodeAddPlayer,
                                    controller: provider.playerNameController,
                                    hintText: appLoc.addPlayer,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(sizeSmall),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () => provider
                                          .addPlayer()
                                          .then((value) => setState(() {})),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: provider.playerSpin
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              String name = entry.value;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: sizeSmall),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(sizeSmall),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: blue,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text("${index + 1}",
                                                style: circleNumberTextStyle),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:
                                            Text(name, style: playerTextStyle),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: gray,
                                        ),
                                        onPressed: () => provider
                                            .removePlayer(index)
                                            .then((value) => setState(() {})),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: sizeExtraLarge),
                          CustomButton(
                            icon: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.black,
                            ),
                            text: appLoc.letsBegin,
                            onPressed: () {
                              if (provider.playerSpin.length == 0) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(appLoc.alert),
                                      content: Text(appLoc.addFirst),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(appLoc.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                Navigator.pushNamed(
                                    context, PlayerSpinPage.routeName);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
