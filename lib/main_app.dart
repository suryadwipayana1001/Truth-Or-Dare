import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/core.dart';
import 'core/presentation/providers/core_provider.dart';
import 'core/presentation/providers/loading_provider.dart';
import 'core/route/route.dart' as router;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
            create: (_) => locator<LoadingProvider>()),
        ChangeNotifierProvider<CoreProvider>(
            create: (_) => locator<CoreProvider>()),
      ],
      builder: (context, _) {
        return Consumer<CoreProvider>(builder: (context, provider, _) {
          return MaterialApp(
            navigatorKey: locator<GlobalKey<NavigatorState>>(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: router.generateRoute,
            locale: Locale("${provider.language!.value}", ''),
            supportedLocales: const [
              Locale('en', ''),
              Locale('id', ''),
              Locale('ar', ''),
              Locale('zh', ''),
              Locale('da', ''),
              Locale('nl', ''),
              Locale('fi', ''),
              Locale('fr', ''),
              Locale('de', ''),
              Locale('el', ''),
              Locale('it', ''),
              Locale('ja', ''),
              Locale('ko', ''),
              Locale('no', ''),
              Locale('pl', ''),
              Locale('pt', ''),
              Locale('ru', ''),
              Locale('es', ''),
              Locale('sv', ''),
              Locale('tr', '')
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashPage(),
          );
        });
      },
    );
  }
}
