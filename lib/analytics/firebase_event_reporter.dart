import 'package:dotd/analytics/event_reporter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseEventReporter implements EventReporter{

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> reportEvent(String eventName) async{
    return analytics.logEvent(name: eventName);
  }
}