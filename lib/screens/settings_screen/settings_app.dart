import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:flutter/material.dart';

class SettingsAppScreen extends StatelessWidget {
  const SettingsAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseEventReporter _firebaseEventReporter = FirebaseEventReporter();
    _firebaseEventReporter.reportScreenView(EventReporter.SETTINGS_SCREEN_VIEWED);
    return const Scaffold(
      body: Center(
        child: Text("Settings app screen"),
      ),
    );
  }
}