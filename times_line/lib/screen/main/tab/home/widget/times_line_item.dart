class TimesLineItem extends ConsumerWidget {
  final int index;
  final VoidCallback onTap;

  const TimesLineItem({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      final todoTaskList = ref.watch(todoHomeListProvider);
      final doneTaskList = ref.watch(doneListProvider);
      
      // 인덱스가 범위를 벗어나면 기본 데이터 생성
      if (index >= todoTaskList.length) {
        _ensureDefaultData(ref, index);
        return _buildDefaultItem(context, index);
      }

      final todoTask = todoTaskList[index];
      final isDone = doneTaskList.any((done) => done.timeline == index);

      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: isDone ? Colors.green.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDone ? Colors.green : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // 시간 표시
              Container(
                width: 60,
                child: Text(
                  '${index.toString().padLeft(2, '0')}:00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDone ? Colors.green : Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // 작업 내용
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (todoTask.title.isNotEmpty)
                      Text(
                        todoTask.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDone ? Colors.green : Colors.black87,
                          decoration: isDone ? TextDecoration.lineThrough : null,
                        ),
                      )
                    else
                      Text(
                        '할 일을 추가해보세요',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    if (todoTask.taskType != TaskType.nill)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getTaskTypeColor(todoTask.taskType).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getTaskTypeText(todoTask.taskType),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getTaskTypeColor(todoTask.taskType),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // 완료 체크박스
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone ? Colors.green : Colors.grey.withOpacity(0.3),
                  border: Border.all(
                    color: isDone ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('TimesLineItem 렌더링 오류: $e');
      return _buildDefaultItem(context, index);
    }
  }

  Widget _buildDefaultItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              '${index.toString().padLeft(2, '0')}:00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              '할 일을 추가해보세요',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.3),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _ensureDefaultData(WidgetRef ref, int index) {
    try {
      final todoTaskList = ref.read(todoHomeListProvider.notifier);
      if (index >= todoTaskList.state.length) {
        // 기본 uid 사용
        final uid = 'default_user';
        
        // 부족한 만큼 기본 데이터 추가
        for (int i = todoTaskList.state.length; i <= index; i++) {
          final defaultTask = TodoTask(
            timeline: i,
            workDate: DateTime.now().formattedDateOnly,
            createdTime: DateTime.now(),
            title: '',
            taskType: TaskType.nill,
            uid: uid,
          );
          todoTaskList.addTodo(defaultTask);
        }
      }
    } catch (e) {
      debugPrint('기본 데이터 생성 오류: $e');
    }
  }

  Color _getTaskTypeColor(TaskType taskType) {
    switch (taskType) {
      case TaskType.work:
        return Colors.blue;
      case TaskType.study:
        return Colors.green;
      case TaskType.exercise:
        return Colors.orange;
      case TaskType.leisure:
        return Colors.purple;
      case TaskType.other:
        return Colors.grey;
      case TaskType.nill:
      default:
        return Colors.grey;
    }
  }

  String _getTaskTypeText(TaskType taskType) {
    switch (taskType) {
      case TaskType.work:
        return '업무';
      case TaskType.study:
        return '학습';
      case TaskType.exercise:
        return '운동';
      case TaskType.leisure:
        return '여가';
      case TaskType.other:
        return '기타';
      case TaskType.nill:
      default:
        return '';
    }
  }
} 