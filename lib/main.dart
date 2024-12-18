import 'dart:async';
import 'package:core_logic/core_logic.dart';
import 'package:core_amplitude/core_amplitude.dart';
import 'package:dicey_quests/src/core/dependency_injection.dart';
import 'package:dicey_quests/src/feature/app/presentation/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };
    WidgetsFlutterBinding.ensureInitialized();
    setupDependencyInjection();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await InitializationUtil.coreInit(
      domain: 'diceyquestaa.com',
      amplitudeKey: '1939384d12b2ba6f563f5e267e18b487',
      appsflyerDevKey: 'zkNAkucoqcY9eVyF93TRfb',
      appId: 'com.dicefox.diceyquest',
      iosAppId: '6739356945',
      initialRoute: '/home',
      facebookClientToken: 'bf05ead0ed9b810af388d82535789b37',
      facebookAppId: '1346626916465358',
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      const AppRoot(),
    );
  }, (Object error, StackTrace stackTrace) {
    _handleAsyncError(error, stackTrace);
  });
}

void _handleFlutterError(FlutterErrorDetails details) {
  AmplitudeUtil.logFailure(
    details.exception is Exception ? Failure.exception : Failure.error,
    details.exception.toString(),
    details.stack,
  );
}

void _handleAsyncError(Object error, StackTrace stackTrace) {
  AmplitudeUtil.logFailure(
    error is Exception ? Failure.exception : Failure.error,
    error.toString(),
    stackTrace,
  );
}
