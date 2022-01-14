import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'extensions/flavor_config.dart';
import 'navigation/home.dart';
import 'navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlavorConfig(flavor: Flavor.MOOR,
    values: FlavorValues(source: "Local Storage"));
  runApp(DoTD(router: AppRouter()));
}