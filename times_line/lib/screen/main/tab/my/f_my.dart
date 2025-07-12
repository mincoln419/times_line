import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/done_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_home_provider.dart';
import 'package:times_line/data/network/todo_api.dart';
import 'package:times_line/screen/main/w_menu_drawer.dart';

class MyFragment extends ConsumerStatefulWidget {
  const MyFragment({super.key});

  @override
  ConsumerState<MyFragment> createState() => _MyFragmentState();
}

class _MyFragmentState extends ConsumerState<MyFragment> {
  DateTime selectedDate = DateTime.now();
  Map<TaskType, int> categoryStats = {};
  int totalTasks = 0;
  int completedTasks = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() => isLoading = true);
    
    try {
      final doneTasks = await TodoApi.instance.getDoneTodoList(selectedDate);
      final todoTasks = await TodoApi.instance.getTodoList(selectedDate);
      
      // 통계 계산
      _calculateStatistics(doneTasks.successData.docs, todoTasks.successData.docs);
    } catch (e) {
      debugPrint('통계 로드 오류: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _calculateStatistics(List doneDocs, List todoDocs) {
    categoryStats.clear();
    completedTasks = 0;
    totalTasks = 0;

    // 완료된 작업 통계
    for (var doc in doneDocs) {
      final task = TodoTask.fromJson(doc.data());
      if (task.title.isNotEmpty && task.taskType != TaskType.nill) {
        completedTasks++;
        categoryStats[task.taskType] = (categoryStats[task.taskType] ?? 0) + 1;
      }
    }

    // 전체 작업 수 계산
    totalTasks = todoDocs.isNotEmpty ? 24 : 0; // 24시간 기준
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: const Text('통계'),
        actions: [
          IconButton(
            onPressed: () => _selectDate(),
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateHeader(),
                  const SizedBox(height: 24),
                  _buildCompletionRate(),
                  const SizedBox(height: 24),
                  _buildCategoryStats(),
                  const SizedBox(height: 24),
                  _buildWeeklyProgress(),
                ],
              ),
            ),
    );
  }

  Widget _buildDateHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.analytics, size: 24),
            const SizedBox(width: 12),
            Text(
              '${selectedDate.formattedDateOnly} 통계',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionRate() {
    final completionRate = totalTasks > 0 ? (completedTasks / totalTasks * 100) : 0;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '작업 완료율',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: completionRate / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      completionRate >= 80 ? Colors.green : 
                      completionRate >= 60 ? Colors.orange : Colors.red,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${completionRate.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('완료: $completedTasks / 전체: $totalTasks'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '카테고리별 통계',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...categoryStats.entries.map((entry) {
              final taskType = entry.key;
              final count = entry.value;
              final percentage = completedTasks > 0 ? (count / completedTasks * 100) : 0;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: getTaskColor(context, taskType),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getTaskTypeName(taskType),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      '$count개 (${percentage.toStringAsFixed(1)}%)',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '주간 진행도',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = selectedDate.subtract(Duration(days: 6 - index));
                final isToday = date.isAtSameMomentAs(DateTime.now());
                
                return Column(
                  children: [
                    Text(
                      _getDayName(date.weekday),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isToday ? AppColors.primaryBlue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isToday ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  String _getTaskTypeName(TaskType taskType) {
    switch (taskType) {
      case TaskType.knowledge:
        return '지식';
      case TaskType.soul:
        return '영성';
      case TaskType.physical:
        return '신체';
      case TaskType.social:
        return '사회';
      case TaskType.sleep:
        return '수면';
      case TaskType.waste:
        return '낭비';
      case TaskType.etc:
        return '기타';
      default:
        return '미분류';
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return '월';
      case 2: return '화';
      case 3: return '수';
      case 4: return '목';
      case 5: return '금';
      case 6: return '토';
      case 7: return '일';
      default: return '';
    }
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => selectedDate = date);
      await _loadStatistics();
    }
  }
}
