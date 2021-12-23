import 'package:dotd/mainCommon.dart';
import 'package:dotd/presentation/home.dart';
import 'package:dotd/presentation/router.dart';
import 'package:flutter/material.dart';

import 'app_config.dart';

void main() {
  var configureApp = AppConfig(
    appDisplayName: "Recipes from Moor",
    appInternalId: 1,
    source: 'MOOR',
    child: DoTD(router: AppRouter()),
  );

  mainCommon();

  runApp(configureApp);
}