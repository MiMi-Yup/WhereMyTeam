import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension ConvertTimestamp on Timestamp {
  static DateFormat formatShortDateTime = DateFormat('hh:mma dd.MM');
  static DateFormat formatSortTime = DateFormat('hh:mma');
  static DateFormat formatDate = DateFormat('dd/MM/yyyy');

  String get toShortDateTime => formatShortDateTime.format(toDate());
  String get toShortTime => formatSortTime.format(toDate());
  String get toMinimalDate => formatDate.format(toDate());
}

extension ConvertString on String {
  DateTime get parseMinimalDate => ConvertTimestamp.formatDate.parse(this);
}

extension ConvertDateTime on DateTime{
  static DateFormat formatDate = DateFormat('hh:mm:ss dd.MM.yy');

  String get toVNFormat => formatDate.format(this);
}
