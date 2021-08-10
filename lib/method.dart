import 'package:intl/intl.dart';

String readTimestamp(int timestamp) {
  var origin = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String createDate = DateFormat('yyyy-MM-dd').format(origin);
  
  return createDate;
}