import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/domain/entities/task_type.dart';
import 'package:times_line/data/services/database_service.dart';
import 'package:times_line/data/models/template.dart';

class TemplateDetailScreen extends ConsumerStatefulWidget {
  final String templateId;

  const TemplateDetailScreen({super.key, required this.templateId});

  @override
  ConsumerState<TemplateDetailScreen> createState() =>
      _TemplateDetailScreenState();
}

class _TemplateDetailScreenState extends ConsumerState<TemplateDetailScreen> {
  Template? _template;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplate();
  }

  Future<void> _loadTemplate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final template = await DatabaseService.getTemplateById(widget.templateId);
      setState(() {
        _template = template;
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
        title: Text(_template?.name ?? '템플릿 ${widget.templateId}'),
        actions: [
          IconButton(
            onPressed: () {
              print(
                '=== 연필 버튼 클릭됨, /template/edit/${widget.templateId}로 이동 ===',
              );
              context.go('/template/edit/${widget.templateId}');
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _template == null
          ? const Center(child: Text('템플릿을 찾을 수 없습니다.'))
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
    final task = _template!.tasks
        .where((task) => task.hour == hour)
        .firstOrNull;

    if (task == null) {
      // 태스크가 없는 경우 빈 시간대 표시
      return _buildEmptyTimeSlot(hour);
    } else {
      // 현재 시간이 연속된 태스크의 시작인지 확인
      if (_isStartOfConsecutiveTask(hour)) {
        // 연속된 태스크의 시작 시간인 경우 묶어서 표시
        final consecutiveTasks = _getConsecutiveSameTasks(hour);
        return _buildConsecutiveTasksCard(consecutiveTasks);
      } else {
        // 연속된 태스크의 중간 시간대인 경우 빈 공간으로 처리
        return const SizedBox.shrink();
      }
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

  Widget _buildConsecutiveTasksCard(List<dynamic> tasks) {
    final startHour = tasks.first.hour;
    final endHour = tasks.last.hour;
    final isMultipleHours = startHour != endHour;
    final task = tasks.first; // 모든 태스크가 같으므로 첫 번째 것 사용

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 시간 범위 표시
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMultipleHours
                        ? '${startHour.toString().padLeft(2, '0')}:00 - ${endHour.toString().padLeft(2, '0')}:00'
                        : '${startHour.toString().padLeft(2, '0')}:00',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (isMultipleHours)
                    Text(
                      '${tasks.length}시간 연속',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
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
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isStartOfConsecutiveTask(int hour) {
    // 이전 시간대의 태스크와 현재 시간대의 태스크가 다른지 확인
    if (hour == 0) return true; // 0시는 항상 시작

    final currentTask = _template!.tasks
        .where((task) => task.hour == hour)
        .firstOrNull;
    final previousTask = _template!.tasks
        .where((task) => task.hour == hour - 1)
        .firstOrNull;

    if (currentTask == null || previousTask == null) return true;

    // 내용이나 타입이 다르면 새로운 연속 체인의 시작
    return currentTask.content != previousTask.content ||
        currentTask.taskType != previousTask.taskType;
  }

  List<dynamic> _getConsecutiveSameTasks(int startHour) {
    final result = <dynamic>[];
    final startTask = _template!.tasks
        .where((task) => task.hour == startHour)
        .firstOrNull;

    if (startTask == null) return result;

    for (int hour = startHour; hour < 24; hour++) {
      final task = _template!.tasks
          .where((task) => task.hour == hour)
          .firstOrNull;

      if (task != null &&
          task.content == startTask.content &&
          task.taskType == startTask.taskType) {
        result.add(task);
      } else {
        // 다른 태스크를 만나면 연속 체인 종료
        break;
      }
    }

    return result;
  }
}
