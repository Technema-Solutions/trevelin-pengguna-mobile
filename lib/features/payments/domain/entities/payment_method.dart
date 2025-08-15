enum PaymentChannel { va, ewallet, qris, card }

class PaymentMethod {
  final PaymentChannel channel;
  final String? bankCode;      // for VA
  final String? ewalletType;   // ex: OVO, DANA
  const PaymentMethod({required this.channel, this.bankCode, this.ewalletType});
}
