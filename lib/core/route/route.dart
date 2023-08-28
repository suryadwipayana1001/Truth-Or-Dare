import 'package:flutter/material.dart';
import 'package:truthordare/features/dare/dare_page.dart';
import 'package:truthordare/features/player_result/player_result_page.dart';
import 'package:truthordare/features/truth/truth_page.dart';
import '../../features/add_player/add_player_page.dart';
import '../../features/landing/landing_page.dart';
import '../../features/player_spin/player_spin_page.dart';
import '../core.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case LandingPage.routeName:
      return MaterialPageRoute(builder: (_) => const LandingPage());
    case AddPlayerPage.routeName:
      return MaterialPageRoute(builder: (_) => const AddPlayerPage());
    case PlayerSpinPage.routeName:
      return MaterialPageRoute(builder: (_) => const PlayerSpinPage());
    case PlayerResultPage.routeName:
      return MaterialPageRoute(builder: (_) => const PlayerResultPage());
    case TruthPage.routeName:
      return MaterialPageRoute(builder: (_) => const TruthPage());
    case DarePage.routeName:
      return MaterialPageRoute(builder: (_) => const DarePage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
