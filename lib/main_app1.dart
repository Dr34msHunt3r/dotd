import 'package:dotd/presentation/home.dart';
import 'package:dotd/presentation/router.dart';
import 'package:flutter/material.dart';

import 'flavor_config.dart';

void main() {
  FlavorConfig(flavor: Flavor.RESTAPI,
      values: FlavorValues(source: "RESTAPI"));
  runApp(DoTD(router: AppRouter()));
}