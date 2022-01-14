import 'package:dotd/navigation/router.dart';
import 'package:flutter/material.dart';


class DoTD extends StatelessWidget {
  const DoTD({Key? key, required this.router}) : super(key: key);

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}