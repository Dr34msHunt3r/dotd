import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({required this.source, required this.appDisplayName, required this.appInternalId,
  required Widget child}) : super(child: child);

  final String appDisplayName;
  final int appInternalId;
  final String source;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>() as AppConfig;
  }
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}