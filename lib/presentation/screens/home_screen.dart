import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/domain/entities/task_type.dart';
import 'package:times_line/data/services/database_service.dart';
import 'package:times_line/data/models/daily_task.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  List<DailyTask> _dailyTasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDailyTasks();
  }

  Future<void> _loadDailyTasks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tasks = await DatabaseService.getDailyTasks(selectedDate);
      setState(() {
        _dailyTasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // 에러 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
        ),
        actions: [
          IconButton(
            onPressed: () => _selectDate(),
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 24,
              itemBuilder: (context, index) {
                return _buildTimeSlot(index);
              },
            ),
    );
  }

  Widget _buildTimeSlot(int hour) {
    // 해당 시간대의 태스크 찾기
    final task = _dailyTasks.where((task) => task.hour == hour).firstOrNull;

    if (task == null) {
      // 태스크가 없는 경우 빈 시간대 표시
      return _buildEmptyTimeSlot(hour);
    } else {
      // 개별 태스크 카드로 표시
      return _buildSingleTaskCard(task, hour);
    }
  }

  Widget _buildEmptyTimeSlot(int hour) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '빈 시간',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleTaskCard(DailyTask task, int hour) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 시간 표시
            SizedBox(
              width: 60,
              child: Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // 컨텐츠 타입과 내용을 같은 row에 표시
            Expanded(
              child: Row(
                children: [
                  // 컨텐츠 타입 (태그)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getTaskColor(context, task.taskType),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      getTaskTypeName(task.taskType),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 컨텐츠 내용
                  Expanded(
                    child: Text(
                      task.content,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted ? Colors.grey : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // 체크박스 스타일의 토글
            _buildCheckboxToggle(task),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxToggle(DailyTask task) {
    return GestureDetector(
      onTap: () async {
        await DatabaseService.updateDailyTaskCompletion(
          selectedDate,
          task.hour,
          !task.isCompleted,
        );
        await _loadDailyTasks(); // 데이터 다시 로드
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: task.isCompleted
              ? getTaskColor(context, task.taskType)
              : Colors.transparent,
          border: Border.all(
            color: task.isCompleted
                ? getTaskColor(context, task.taskType)
                : Colors.grey.shade400,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: task.isCompleted
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
      await _loadDailyTasks(); // 새로운 날짜의 데이터 로드
    }
  }
}
