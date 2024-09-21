import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/diary/diary_content.dart';
import 'package:times_line/entity/diary/diary_type.dart';
import 'package:times_line/screen/main/tab/diary/diary_item_widget.dart';
import 'package:times_line/screen/main/tab/diary/provider/diary_data_provider.dart';
import 'package:times_line/screen/main/tab/diary/provider/diary_select_date_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_editor_provider.dart';

import '../../w_menu_drawer.dart';
import '../home/provider/todo_task_provider.dart';

class ThreeLineDiary extends ConsumerStatefulWidget {
  const ThreeLineDiary({super.key});

  @override
  ConsumerState<ThreeLineDiary> createState() => _ThreeLineDiaryState();
}

class _ThreeLineDiaryState extends ConsumerState<ThreeLineDiary> {
  final controller = TextEditingController();

  late String selectedDate = DateTime.now().formattedDateOnly;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<DiaryContent> list = ref.watch(diaryDataProvider);
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                selectedDate.text.size(15).make(),
                IconButton(
                  onPressed: () {
                    _selectDate();
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: _diaryFuture(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => DiaryItem(
                            tec: TextEditingController(),
                            content: snapshot.data![index]),
                        separatorBuilder: (_, index) =>
                            const Line().pSymmetric(h: 15),
                        itemCount: snapshot.data!.length),
                  );
                }

                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }

  void _selectDate() async {
    final selectedDate = ref.watch(selectedDiaryDateProvider.notifier);

    final date = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectedDiaryDateProvider),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      ref.readDairyHolder.clear();
      selectedDate.changeDate(DateUtils.dateOnly(date));
      //selectedDateTaskList();
    }
  }

  Future<List<DiaryContent>> _diaryFuture() async {
    final list = ref.watch(diaryDataProvider);
    final textTecList = ref.watch(tecListProvider);
    if (list.isEmpty) {
      await RangeStream(0, 2).forEach((i) {
        list.add(DiaryContent(
            uid: 'abc',
            contents: ,
            diaryType: DiaryType.values[i],
            workDate: selectedDate,
            sortOrder: i));
      });
    }
    return list;
  }
}
