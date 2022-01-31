import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'base/app_config.dart';
import 'base/firebase_remote_config.dart';
import 'extensions/flavor_config.dart';

import 'navigation/auto_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseRemoteConfig config = FirebaseRemoteConfig();
  await config.initialise();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlavorConfig(flavor: Flavor.RESTAPI,
      values: FlavorValues(source: "Rest API"));
  runApp(DoTDConfig(config: config, appRoute: AppRouter(),));
}