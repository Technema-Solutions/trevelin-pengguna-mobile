import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/payment_status.dart';

class PaymentIntentModel {
  PaymentIntentModel({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.method,
    required this.status,
    this.redirectUrl,
    this.vaNumber,
    this.qrisPayload,
    required this.createdAt,
    required this.expiresAt,
  });

  final String id;
  final String bookingId;
  final int amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? redirectUrl;
  final String? vaNumber;
  final String? qrisPayload;
  final DateTime createdAt;
  final DateTime expiresAt;

  factory PaymentIntentModel.fromEntity(PaymentIntent e) => PaymentIntentModel(
        id: e.id,
        bookingId: e.bookingId,
        amount: e.amount,
        method: e.method,
        status: e.status,
        redirectUrl: e.redirectUrl,
        vaNumber: e.vaNumber,
        qrisPayload: e.qrisPayload,
        createdAt: e.createdAt,
        expiresAt: e.expiresAt,
      );

  PaymentIntent toEntity() => PaymentIntent(
        id: id,
        bookingId: bookingId,
        amount: amount,
        method: method,
        status: status,
        redirectUrl: redirectUrl,
        vaNumber: vaNumber,
        qrisPayload: qrisPayload,
        createdAt: createdAt,
        expiresAt: expiresAt,
      );

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) => PaymentIntentModel(
        id: json['id'] as String,
        bookingId: json['bookingId'] as String,
        amount: json['amount'] as int,
        method: PaymentMethod(
          channel: PaymentChannel.values.firstWhere(
              (e) => e.name == json['channel'] as String),
          bankCode: json['bankCode'] as String?,
          ewalletType: json['ewalletType'] as String?,
        ),
        status: PaymentStatus.values
            .firstWhere((e) => e.name == json['status'] as String),
        redirectUrl: json['redirectUrl'] as String?,
        vaNumber: json['vaNumber'] as String?,
        qrisPayload: json['qrisPayload'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        expiresAt: DateTime.parse(json['expiresAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingId': bookingId,
        'amount': amount,
        'channel': method.channel.name,
        'bankCode': method.bankCode,
        'ewalletType': method.ewalletType,
        'status': status.name,
        'redirectUrl': redirectUrl,
        'vaNumber': vaNumber,
        'qrisPayload': qrisPayload,
        'createdAt': createdAt.toIso8601String(),
        'expiresAt': expiresAt.toIso8601String(),
      };
}
