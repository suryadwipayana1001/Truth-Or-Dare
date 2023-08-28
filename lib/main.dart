import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/core.dart';
import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    //     testDeviceIds: ['6F085438-AE4A-4AD2-83E5-9C9DEDA499BE']));

    await checkConsent();
    await MobileAds.instance.initialize();
    await locatorInit();
    locator.isReady<Session>().then((_) async {
      return runApp(const MainApp());
    });
  } catch (e) {
    logMe(e);
  }
}

Future<void> checkConsent() async {
  ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(
          // consentDebugSettings: ConsentDebugSettings(
          //   debugGeography: DebugGeography.debugGeographyEea,
          //   testIdentifiers: ['6F085438-AE4A-4AD2-83E5-9C9DEDA499BE'],
          // ),
          ), () async {
    if (await ConsentInformation.instance.isConsentFormAvailable()) {
      loadForm();
    }
  }, (error) {
    printWarning("Error executing Consent Information initialize");
    printError("Error Code: ${error.errorCode}");
    printError("Error Msg: ${error.message}");
  });
}

Future<void> loadForm() async {
  ConsentForm.loadConsentForm((consentForm) async {
    var status = await ConsentInformation.instance.getConsentStatus();
    if (status == ConsentStatus.required) {
      consentForm.show(
        (formError) {
          if (formError != null) {
            printError("Err Code: ${formError.errorCode}");
            printError("Err Msg: ${formError.message}");
          }
          loadForm();
        },
      );
    }
  }, (formError) {
    printError("Err Code: ${formError.errorCode}");
    printError("Err Msg: ${formError.message}");
  });
}
