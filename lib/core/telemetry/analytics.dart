import 'package:flutter/foundation.dart';

/// Abstraction for analytics events.
abstract class Analytics {
  Future<void> init();
  void log(String event, {Map<String, Object?> params = const {}});
}

/// Console implementation used for development/testing.
class ConsoleAnalytics implements Analytics {
  @override
  Future<void> init() async {}

  @override
  void log(String event, {Map<String, Object?> params = const {}}) {
    debugPrint('[ANALYTICS] $event $params');
  }
}

/// Canonical analytics events used by the app.
class AnalyticsEvents {
  AnalyticsEvents._();

  static const searchPerformed = 'search_performed';
  static const scheduleViewed = 'schedule_viewed';
  static const seatSelected = 'seat_selected';
  static const bookingInitiated = 'booking_initiated';
  static const paymentIntentCreated = 'payment_intent_created';
  static const paymentPaid = 'payment_paid';
  static const packageViewed = 'package_viewed';
  static const feedbackSent = 'feedback_sent';
}
