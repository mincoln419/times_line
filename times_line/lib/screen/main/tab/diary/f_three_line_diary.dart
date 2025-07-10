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
import '../home/provider/diary_editor_provider.dart';
import '../home/provider/todo_task_provider.dart';
import '../../../../data/network/diary/diary_api.dart';

class ThreeLineDiary extends ConsumerStatefulWidget {
  const ThreeLineDiary({super.key});

  @override
  ConsumerState<ThreeLineDiary> createState() => _ThreeLineDiaryState();
}

class _ThreeLineDiaryState extends ConsumerState<ThreeLineDiary> {
  late String selectedDate = DateTime.now().formattedDateOnly;
  bool isLoading = true;
  final List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadDiaryData();
  }

  void _initializeControllers() {
    controllers.clear();
    for (int i = 0; i < 3; i++) {
      controllers.add(TextEditingController());
    }
  }

  Future<void> _loadDiaryData() async {
    setState(() => isLoading = true);
    
    try {
      final diaryList = ref.watch(diaryDataProvider);
      final selectedDateTime = ref.watch(selectedDiaryDateProvider);
      
      // 기존 데이터 로드
      ref.readDairyHolder.initDiary(selectedDateTime);
      
      // 컨트롤러에 데이터 설정
      for (int i = 0; i < 3 && i < diaryList.length; i++) {
        controllers[i].text = diaryList[i].contents;
      }
    } catch (e) {
      debugPrint('일기 데이터 로드 오류: $e');
      // 에러 발생 시 기본 데이터 생성
      _initializeDefaultDiary();
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _initializeDefaultDiary() {
    final diaryList = ref.watch(diaryDataProvider);
    if (diaryList.isEmpty) {
      // 기본 3줄 일기 생성
      for (int i = 0; i < 3; i++) {
        final diaryContent = DiaryContent(
          uid: ref.watch(userProvider).value!,
          contents: '',
          diaryType: DiaryType.values[i],
          workDate: selectedDate,
          sortOrder: i,
        );
        ref.readDairyHolder.addDiary(diaryContent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DiaryContent> diaryList = ref.watch(diaryDataProvider);
    final selectedDateTime = ref.watch(selectedDiaryDateProvider);
    
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                selectedDateTime.formattedDateOnly.text.size(15).make(),
                IconButton(
                  onPressed: () => _selectDate(),
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            IconButton(
              onPressed: () => _saveDiary(),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDiaryContent(diaryList),
    );
  }

  Widget _buildDiaryContent(List<DiaryContent> diaryList) {
    // 데이터가 없으면 기본 생성
    if (diaryList.isEmpty) {
      _initializeDefaultDiary();
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) => DiaryItem(
              tec: controllers[index],
              content: diaryList[index],
              onChanged: (text) {
                _updateDiaryContent(index, text);
              },
            ),
            separatorBuilder: (_, index) =>
                const Line().pSymmetric(h: 15),
            itemCount: diaryList.length,
          ),
        ),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: _saveDiary,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
        ),
        child: const Text('일기 저장'),
      ),
    );
  }

  void _updateDiaryContent(int index, String text) {
    final diaryList = ref.watch(diaryDataProvider);
    if (index < diaryList.length) {
      final updatedContent = diaryList[index].copyWith(contents: text);
      ref.readDairyHolder.updateDiary(updatedContent);
    }
  }

  Future<void> _saveDiary() async {
    try {
      final diaryList = ref.watch(diaryDataProvider);
      
      // 모든 일기 내용 저장
      for (final diary in diaryList) {
        if (diary.contents.isNotEmpty) {
          await DiaryApi.instance.addDiary(diary);
        }
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('일기가 저장되었습니다.')),
        );
      }
    } catch (e) {
      debugPrint('일기 저장 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  void _selectDate() async {
    final selectedDateProvider = ref.read(selectedDiaryDateProvider.notifier);
    final currentDate = ref.watch(selectedDiaryDateProvider);

    final date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    
    if (date != null) {
      ref.readDairyHolder.clear();
      selectedDateProvider.changeDate(DateUtils.dateOnly(date));
      _initializeControllers();
      await _loadDiaryData();
    }
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
