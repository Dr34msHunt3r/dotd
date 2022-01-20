import 'package:dotd/base/firebase_remote_config.dart';
import 'package:dotd/config/app_colors.dart';
import 'package:dotd/extensions/value_to_color.dart';
import 'package:dotd/navigation/router.dart';
import 'package:flutter/material.dart';


class DoTD extends StatelessWidget {
  const DoTD({Key? key, required this.router, required this.config}) : super(key: key);

  final AppRouter router;
  final FirebaseRemoteConfig config;

  @override
  Widget build(BuildContext context) {
    final primaryColor = config.appThemeConfigDto.primaryColor?.toColor();
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: primaryColor??AppColors.pink
        ),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
