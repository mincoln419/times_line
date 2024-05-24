
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/screen/main/tab/diary/provider/diary_select_date_provider.dart';

import '../../../../../data/network/diary/diary_api.dart';
import '../../../../../entity/diary/diary_content.dart';
import '../../home/provider/todo_task_provider.dart';


final diaryDataProvider =
StateNotifierProvider<DiaryDataHolder, List<DiaryContent>>((ref) {
  final userID = ref.watch(userProvider);
  return DiaryDataHolder();
});

class DiaryDataHolder extends StateNotifier<List<DiaryContent>> {
  DiaryDataHolder() : super([]);

  void initDiary(DateTime selectedDate) async {
    DiaryApi.instance.getSelectDateDiary(selectedDate).then((value) => {
      for(dynamic data in value.successData.docs){
        state.add(DiaryContent.fromJson(data))
      }
    });
  }

  void addDiary(DiaryContent diary) async {
    state.add(diary);
    state = List.of(state);
    DiaryApi.instance.addDiary(diary);
  }

  void updateDiary(DiaryContent diary) async {
    state = List.of(state);
    for(DiaryContent data in state){
      if(data.diaryType == diary.diaryType){
        data.contents = diary.contents;
      }
    }
    DiaryApi.instance.addDiary(diary);
  }

  void removeTodo(DiaryContent diary) {
    state.remove(diary);
    state = List.of(state);
  }

  void clear() {
    state.clear();
  }

  void changeWorkDate(DateTime date) {
    for (var element in state) {
      element.workDate = date.formattedDateOnly;
    }
  }
}

extension DiaryHolderProvider on WidgetRef {
  DiaryDataHolder get readDairyHolder => read(diaryDataProvider.notifier);
}