import 'package:dotd/presentation/home.dart';
import 'package:dotd/presentation/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlavorConfig(flavor: Flavor.SECURE_STORAGE,
  values: FlavorValues(source: "SECURE_STORAGE"));

  runApp(DoTD(router: AppRouter()));
}