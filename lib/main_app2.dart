import 'package:dotd/presentation/home.dart';
import 'package:dotd/presentation/router.dart';
import 'package:flutter/material.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig(flavor: Flavor.MOOR,
  values: FlavorValues(source: "MOOR"));
  runApp(DoTD(router: AppRouter()));
}