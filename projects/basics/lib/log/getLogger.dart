// ignore: file_names
import 'package:logger/logger.dart';

Logger getLogger() {
  return Logger(printer: PrettyPrinter(printTime: true,));
}