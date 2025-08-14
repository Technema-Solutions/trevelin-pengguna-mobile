import 'package:intl/intl.dart';

/// Common formatters used across the app.
final _currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

String formatCurrency(num value) => _currencyFormatter.format(value);
