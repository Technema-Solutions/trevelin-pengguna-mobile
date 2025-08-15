import 'dart:math';

import 'package:uuid/uuid.dart';

import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/payment_status.dart';
import '../../domain/services/payment_gateway.dart';

class PaymentGatewayMock implements PaymentGateway {
  PaymentGatewayMock({this.onWebhook});

  final void Function(Map<String, dynamic> payload)? onWebhook;
  final _uuid = const Uuid();
  final _rng = Random();
  final Map<String, PaymentIntent> _intents = {};
  final Map<String, String> _idempotency = {};

  @override
  Future<PaymentIntent> createIntent({
    required String bookingId,
    required int amount,
    required PaymentMethod method,
    required String idempotencyKey,
    Map<String, dynamic>? metadata,
  }) async {
    if (_idempotency.containsKey(idempotencyKey)) {
      return _intents[_idempotency[idempotencyKey]!]!;
    }
    final id = _uuid.v4();
    final now = DateTime.now();
    final expires = now.add(const Duration(minutes: 30));
    PaymentStatus status =
        (method.channel == PaymentChannel.ewallet || method.channel == PaymentChannel.card)
            ? PaymentStatus.requiresAction
            : PaymentStatus.pending;
    String? va;
    String? redirect;
    String? qris;
    switch (method.channel) {
      case PaymentChannel.va:
        va = '8808-${_rng.nextInt(90000000) + 10000000}';
        break;
      case PaymentChannel.ewallet:
      case PaymentChannel.card:
        redirect = 'https://mock.pay/redirect/$id';
        break;
      case PaymentChannel.qris:
        qris = '000201010212MOCK$id';
        break;
    }
    final intent = PaymentIntent(
      id: id,
      bookingId: bookingId,
      amount: amount,
      method: method,
      status: status,
      redirectUrl: redirect,
      vaNumber: va,
      qrisPayload: qris,
      createdAt: now,
      expiresAt: expires,
    );
    _intents[id] = intent;
    _idempotency[idempotencyKey] = id;
    return intent;
  }

  @override
  Future<PaymentIntent> getIntent(String paymentId) async {
    final intent = _intents[paymentId];
    if (intent == null) throw Exception('not found');
    return intent;
  }

  @override
  Future<void> simulateProviderSetPaid(String paymentId) async {
    final current = _intents[paymentId];
    if (current == null) return;
    final updated = PaymentIntent(
      id: current.id,
      bookingId: current.bookingId,
      amount: current.amount,
      method: current.method,
      status: PaymentStatus.paid,
      redirectUrl: current.redirectUrl,
      vaNumber: current.vaNumber,
      qrisPayload: current.qrisPayload,
      createdAt: current.createdAt,
      expiresAt: current.expiresAt,
    );
    _intents[paymentId] = updated;
    onWebhook?.call({
      'type': 'payment.paid',
      'data': {'paymentId': paymentId, 'status': 'paid'},
      'signature': 'mock',
    });
  }
}
