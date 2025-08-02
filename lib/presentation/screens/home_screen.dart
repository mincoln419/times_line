import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/domain/entities/task_type.dart';
import 'package:times_line/data/services/database_service.dart';
import 'package:times_line/data/models/daily_task.dart';
import 'package:times_line/data/models/template.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  List<DailyTask> _dailyTasks = [];
  List<Template> _templates = [];
  Template? _selectedTemplate;
  bool _isLoading = true;
  bool _isTemplateConfirmed = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadDailyTasks(),
      _loadTemplates(),
    ]);
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

  Future<void> _loadTemplates() async {
    try {
      final templates = await DatabaseService.getAllTemplates();
      setState(() {
        _templates = templates;
      });
    } catch (e) {
      // 에러 처리
    }
  }

  Future<void> _confirmTemplate() async {
    if (_selectedTemplate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('템플릿을 선택해주세요')),
      );
      return;
    }

    try {
      // 기존 DailyTask 삭제
      await DatabaseService.deleteDailyTasks(selectedDate);

      // 템플릿의 각 태스크를 DailyTask로 변환하여 저장
      for (final templateTask in _selectedTemplate!.tasks) {
        final dailyTask = DailyTask()
          ..date = selectedDate
          ..hour = templateTask.hour
          ..content = templateTask.content
          ..taskType = templateTask.taskType
          ..isCompleted = false
          ..templateId = _selectedTemplate!.id.toString()
          ..plannedContent = templateTask.content
          ..plannedTaskType = templateTask.taskType
          ..actualContent = ''
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();

        await DatabaseService.saveDailyTask(dailyTask);
      }

      setState(() {
        _isTemplateConfirmed = true;
      });

      await _loadDailyTasks();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('템플릿이 확정되었습니다')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('템플릿 확정 중 오류가 발생했습니다: $e')),
      );
    }
  }

  Widget _buildTemplateSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.blue.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '템플릿 선택',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Template>(
                  value: _selectedTemplate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  hint: const Text('템플릿을 선택하세요'),
                  items: _templates.map((template) {
                    return DropdownMenuItem<Template>(
                      value: template,
                      child: Text(template.name),
                    );
                  }).toList(),
                  onChanged: (Template? value) {
                    setState(() {
                      _selectedTemplate = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _confirmTemplate,
                child: const Text('확정'),
              ),
            ],
          ),
        ],
      ),
    );
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
          : Column(
              children: [
                // 템플릿 선택 섹션
                if (!_isTemplateConfirmed) _buildTemplateSelectionSection(),
                
                // 시간대 목록
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 24,
                    itemBuilder: (context, index) {
                      return _buildTimeSlot(index);
                    },
                  ),
                ),
              ],
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

            // 예정된 일과 실제 한 일을 구분하여 표시
            Expanded(
              child: Row(
                children: [
                  // 예정된 일 (왼쪽)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 예정된 일의 TaskType 태그
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getTaskColor(context, task.plannedTaskType),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            getTaskTypeName(task.plannedTaskType),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 예정된 일의 내용
                        Text(
                          task.plannedContent ?? '예정된 일 없음',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 실제 한 일 (오른쪽)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 실제 한 일의 TaskType 태그
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getTaskColor(context, task.taskType),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            getTaskTypeName(task.taskType),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 실제 한 일의 내용 (편집 가능)
                        _isTemplateConfirmed
                            ? TextField(
                                controller: TextEditingController(text: task.actualContent ?? ''),
                                decoration: const InputDecoration(
                                  hintText: '실제 한 일을 입력하세요',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                                style: const TextStyle(fontSize: 12),
                                onChanged: (value) {
                                  DatabaseService.updateDailyTaskActualContent(
                                    selectedDate,
                                    task.hour,
                                    value,
                                  );
                                },
                              )
                            : Text(
                                '템플릿 확정 후 입력 가능',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                      ],
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
      onTap: _isTemplateConfirmed ? () async {
        // 체크박스를 누르면 예정된 일로 실제 한 일을 덮어쓰기
        if (task.plannedContent != null && task.plannedTaskType != null) {
          await DatabaseService.updateDailyTaskActualContent(
            selectedDate,
            task.hour,
            task.plannedContent!,
          );
          // TaskType도 예정된 일의 TaskType으로 변경
          final updatedTask = await DatabaseService.getDailyTask(selectedDate, task.hour);
          if (updatedTask != null) {
            updatedTask.taskType = task.plannedTaskType!;
            updatedTask.updatedAt = DateTime.now();
            await DatabaseService.saveDailyTask(updatedTask);
          }
        }
        
        await DatabaseService.updateDailyTaskCompletion(
          selectedDate,
          task.hour,
          !task.isCompleted,
        );
        await _loadDailyTasks(); // 데이터 다시 로드
      } : null,
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
        _isTemplateConfirmed = false; // 날짜 변경 시 템플릿 확정 상태 초기화
      });
      await _loadDailyTasks(); // 새로운 날짜의 데이터 로드
    }
  }
}
