import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

class TodoHomeListNotifier extends StateNotifier<List<TodoTask>> {
  TodoHomeListNotifier() : super([]) {
    // 초기화는 나중에 수행
  }

  void _initializeDefaultTasks() {
    if (state.isEmpty) {
      try {
        // 기본 uid 사용 (실제로는 로그인 후 사용자 uid를 사용해야 함)
        final uid = 'default_user';
        
        final defaultTasks = List.generate(24, (i) => TodoTask(
          timeline: i,
          workDate: DateTime.now().formattedDateOnly,
          createdTime: DateTime.now(),
          title: '',
          taskType: TaskType.nill,
          uid: uid,
        ));
        state = defaultTasks;
      } catch (e) {
        debugPrint('TodoHomeListNotifier 초기화 오류: $e');
        // 오류 발생 시 빈 리스트로 시작
        state = [];
      }
    }
  }

  void addTodo(TodoTask todo) {
    state = [...state, todo];
  }

  void updateTodo(int index, TodoTask todo) {
    final newList = List<TodoTask>.from(state);
    if (index < newList.length) {
      newList[index] = todo;
      state = newList;
    }
  }

  void removeTodo(int index) {
    final newList = List<TodoTask>.from(state);
    if (index < newList.length) {
      newList.removeAt(index);
      state = newList;
    }
  }

  void clear() {
    state = [];
  }

  void refreshTasks() {
    _initializeDefaultTasks();
  }

  void initializeTasks() {
    _initializeDefaultTasks();
  }
} 