import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension ConvertTimestamp on Timestamp {
  static DateFormat format = DateFormat('hh:mma dd.MM');
  
  String get toShortTime => format.format(toDate());
}
