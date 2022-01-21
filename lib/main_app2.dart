import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'base/firebase_remote_config.dart';
import 'extensions/flavor_config.dart';
import 'base/home.dart';
import 'navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseRemoteConfig config = FirebaseRemoteConfig();
  await config.initialise();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlavorConfig(flavor: Flavor.MOOR,
    values: FlavorValues(source: "Local Storage"));
  runApp(DoTD(router: AppRouter(), config: config));
}