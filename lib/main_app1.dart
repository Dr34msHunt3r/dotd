import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'base/firebase_remote_config.dart';
import 'extensions/flavor_config.dart';
import 'base/home.dart';
import 'navigation/router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseRemoteConfig config = FirebaseRemoteConfig();
  await config.initialise();
  FlavorConfig(flavor: Flavor.RESTAPI,
      values: FlavorValues(source: "Rest API"));
  runApp(DoTD(router: AppRouter(), config: config));
}