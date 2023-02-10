import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Utils {
  static final usdCurrencyFormat = NumberFormat('\$#,##0.00');

  static Logger getLogger() {
    return Logger(printer: PrettyPrinter(printTime: true,));
  }
}