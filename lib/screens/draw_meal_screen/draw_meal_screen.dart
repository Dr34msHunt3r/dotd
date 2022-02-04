import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:flutter/material.dart';

class DrawMealScreen extends StatelessWidget {
  const DrawMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseEventReporter _firebaseEventReporter = FirebaseEventReporter();
    _firebaseEventReporter.reportScreenView(EventReporter.RANDOM_MEAL_SCREEN_VIEWED);
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw meal!'),
      ),
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(context) {
    return Center(
      child: const Text('Here you will draw random idea for dinner :)'),
    );
  }

}