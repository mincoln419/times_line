

import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('dd/MM/yyyy HH:mm').format(this);

  String get formattedDateOnly => DateFormat('yyyy-MM-dd').format(this);

}
