import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/domain/entities/task_type.dart';
import 'package:times_line/data/services/database_service.dart';
import 'package:times_line/data/models/template.dart';

class TemplateEditScreen extends ConsumerStatefulWidget {
  final String? templateId; // null이면 새로 생성, 있으면 수정

  const TemplateEditScreen({super.key, this.templateId});

  @override
  ConsumerState<TemplateEditScreen> createState() => _TemplateEditScreenState();
}

class _TemplateEditScreenState extends ConsumerState<TemplateEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final List<TemplateTask> _tasks = [];
  final List<TextEditingController> _taskControllers = [];
  bool _isLoading = true;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    print('=== TemplateEditScreen initState 호출됨 ===');
    print('templateId: ${widget.templateId}');

    _initializeTasks();

    if (widget.templateId != null) {
      print('기존 템플릿 수정 모드');
      _loadTemplate();
    } else {
      print('새 템플릿 생성 모드');
      _isLoading = false;
    }
  }

  void _initializeTasks() {
    print('=== _initializeTasks 호출됨 ===');
    _tasks.clear();
    _taskControllers.clear();

    // 24개 항목을 고정으로 생성
    for (int i = 0; i < 24; i++) {
      final task = TemplateTask()
        ..hour = i
        ..content = ''
        ..taskType = TaskType.spiritual;
      _tasks.add(task);

      final controller = TextEditingController(text: '');
      _taskControllers.add(controller);
    }

    print('템플릿 편집 화면: ${_tasks.length}개 항목 초기화 완료');
  }

  Future<void> _loadTemplate() async {
    try {
      final template = await DatabaseService.getTemplateById(
        widget.templateId!,
      );
      if (template != null) {
        setState(() {
          _nameController.text = template.name;
          _isEditing = true;

          // 기존 태스크들을 로드하고 24개로 맞춤
          _tasks.clear();
          _taskControllers.clear();

          for (int i = 0; i < 24; i++) {
            if (i < template.tasks.length) {
              _tasks.add(template.tasks[i]);
              _taskControllers.add(
                TextEditingController(text: template.tasks[i].content),
              );
            } else {
              final task = TemplateTask()
                ..hour = i
                ..content = ''
                ..taskType = TaskType.spiritual;
              _tasks.add(task);
              _taskControllers.add(TextEditingController(text: ''));
            }
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('템플릿 로드 중 오류가 발생했습니다: $e')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final controller in _taskControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=== TemplateEditScreen build 호출됨 ===');
    print('_isLoading: $_isLoading, _tasks.length: ${_tasks.length}');

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '템플릿 수정' : '새 템플릿 생성'),
        actions: [
          IconButton(
            onPressed: _saveTemplate,
            icon: const Icon(Icons.save),
            tooltip: '저장',
          ),
          IconButton(
            onPressed: _cancelEdit,
            icon: const Icon(Icons.close),
            tooltip: '취소',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 디버그 정보 (홈화면 스타일에 맞게)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue.shade600,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_tasks.length}개 항목 | 편집모드: $_isEditing | 로딩: $_isLoading',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTemplateNameField(),
                Expanded(child: _buildTaskList()),
              ],
            ),
    );
  }

  Widget _buildTemplateNameField() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: '템플릿 이름',
          hintText: '템플릿 이름을 입력하세요',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskItem(index);
      },
    );
  }

  Widget _buildTaskItem(int index) {
    final task = _tasks[index];
    final controller = _taskControllers[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 시간 표시 (홈화면과 동일한 스타일)
            SizedBox(
              width: 60,
              child: Text(
                '${index.toString().padLeft(2, '0')}:00',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Task Type과 Content를 같은 row에 표시 (홈화면과 동일한 레이아웃)
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Task Type (홈화면과 동일한 태그 스타일)
                  GestureDetector(
                    onTap: () => _showTaskTypeDialog(context, task),
                    child: Container(
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
                  ),
                  const SizedBox(width: 12),

                  // Content 입력 필드 (홈화면과 동일한 텍스트 스타일)
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: '할일을 입력하세요',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 16),
                      onChanged: (value) {
                        setState(() {
                          task.content = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // 편집 화면에서는 아이콘 없이 빈 공간 유지 (홈화면의 체크박스와 동일한 위치)
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  String getTaskTypeName(TaskType type) {
    switch (type) {
      case TaskType.spiritual:
        return '영성';
      case TaskType.intellectual:
        return '지적';
      case TaskType.social:
        return '사회적';
      case TaskType.physical:
        return '신체적';
      case TaskType.waste:
        return '낭비';
      case TaskType.sleep:
        return '잠';
    }
  }

  Future<void> _saveTemplate() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('템플릿 이름을 입력해주세요')));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('저장 확인'),
        content: const Text('저장하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('저장'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final template = Template()
          ..name = _nameController.text.trim()
          ..tasks = _tasks.where((task) => task.content.isNotEmpty).toList()
          ..isDefault = false
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();

        if (_isEditing && widget.templateId != null) {
          template.id = int.parse(widget.templateId!);
        }

        await DatabaseService.saveTemplate(template);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isEditing ? '템플릿이 수정되었습니다' : '템플릿이 생성되었습니다'),
            ),
          );
          context.go('/template');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')));
        }
      }
    }
  }

  Future<void> _cancelEdit() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('취소 확인'),
        content: const Text('취소하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('계속 편집'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('취소'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (mounted) {
        context.go('/template');
      }
    }
  }

  void _showTaskTypeDialog(BuildContext context, TemplateTask task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Task Type 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: TaskType.values.map((type) {
            return ListTile(
              leading: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: getTaskColor(context, type),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: Text(getTaskTypeName(type)),
              onTap: () {
                setState(() {
                  task.taskType = type;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
