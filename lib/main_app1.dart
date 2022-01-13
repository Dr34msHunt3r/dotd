import 'package:dotd/presentation/home.dart';
import 'package:dotd/presentation/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'flavor_config.dart';

void main() async{
  FlavorConfig(flavor: Flavor.RESTAPI,
      values: FlavorValues(source: "RESTAPI"));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DoTD(router: AppRouter()));
}