import 'package:dotd/analytics/event_reporter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseEventReporter implements EventReporter{

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> reportEvent(String eventName) async{
    return _analytics.logEvent(name: eventName);
  }

  @override
  Future<void> reportScreenView(String screenName) async{
    return _analytics.logScreenView(screenName: screenName);
  }
}