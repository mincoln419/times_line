import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDiaryDateProvider =
StateNotifierProvider<SelectDiaryDateDataHolder, DateTime>(
        (ref) => SelectDiaryDateDataHolder());

class SelectDiaryDateDataHolder extends StateNotifier<DateTime> {
  SelectDiaryDateDataHolder() : super(DateUtils.dateOnly(DateTime.now()));

  void changeDate(DateTime dateTime) {
    state = dateTime;
  }
}
extension SelectDiaryDateDataHolderProvider on WidgetRef {
  SelectDiaryDateDataHolder get readSelectDiaryDateHolder => read(selectedDiaryDateProvider.notifier);
}
