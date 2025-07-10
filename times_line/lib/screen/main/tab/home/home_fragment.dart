import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/streams.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/todo_task_template.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/done_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_home_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/home/w_times_line_item.dart';
import 'package:uuid/uuid.dart';
import 'package:times_line/common/dropdown/todo_tasktype_dropdown.dart';
import '../../../../data/network/todo_api.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final ScrollController scrollController = ScrollController();
  double turns = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureDefaultData();
      _loadInitialData();
    });
  }

  void _ensureDefaultData() {
    try {
      final todoTaskList = ref.read(todoHomeListProvider);
      if (todoTaskList.isEmpty) {
        final today = DateTime.now();
        final uid = 'default_user';
        
        final defaultTasks = List.generate(24, (i) => TodoTask(
          timeline: i,
          workDate: today.formattedDateOnly,
          createdTime: DateTime.now(),
          title: '',
          taskType: TaskType.nill,
          uid: uid,
        ));

        // Provider에 데이터 추가
        final provider = ref.read(todoHomeListProvider.notifier);
        provider.clear();
        for (var task in defaultTasks) {
          provider.addTodo(task);
        }

        debugPrint('HomeFragment: 기본 데이터 생성 완료');
      }
    } catch (e) {
      debugPrint('HomeFragment: 기본 데이터 생성 오류: $e');
    }
  }

  Future<void> _loadInitialData() async {
    if (!mounted) return;
    
    setState(() => isLoading = true);
    try {
      await todoListStream();
    } catch (e) {
      debugPrint('데이터 로드 오류: $e');
      // 에러 발생 시에도 기본 데이터는 유지
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedHomeDateProvider);
    final todoTaskList = ref.watch(todoHomeListProvider);
    final doneTaskList = ref.watch(doneListProvider);

    debugPrint('todoTaskList length: \\${todoTaskList.length}');
    debugPrint('todoTaskList: \\${todoTaskList}');

    return Column(
      children: [
        AppBar(
          title: Row(
            children: [
              Row(
                children: [
                  selectedDate.formattedDateOnly.text.size(15).make(),
                  IconButton(
                    onPressed: () => _selectDate(),
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // TODO: 알림 기능 구현
              },
              icon: const Icon(Icons.notifications_none_rounded),
            )
          ],
        ),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildTodoList(todoTaskList, doneTaskList),
        ),
      ],
    );
  }

  Widget _buildTodoList(List<TodoTask> todoTaskList, List<TodoTask> doneTaskList) {
    // 데이터가 없으면 기본 24시간 리스트 생성
    if (todoTaskList.isEmpty) {
      _ensureDefaultData();
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('데이터를 로딩 중입니다...'),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: FloatingDaangnButton.height),
      controller: scrollController,
      itemBuilder: (context, index) => TimesLineItem(
        index: index,
        onTap: () => _showTaskEditDialog(index, doneTaskList),
      ),
      itemCount: todoTaskList.length,
      separatorBuilder: (context, index) => const Line().pSymmetric(h: 15),
    );
  }

  void _showTaskEditDialog(int index, List<TodoTask> doneTaskList) async {
    if (index >= doneTaskList.length) return;
    
    final task = doneTaskList[index];
    final TextEditingController tec = TextEditingController(text: task.title);
    
    ref.watch(currentTaskTypeProvider).currentTypeOnChange(task.taskType);
    
    if (!mounted) return;
    
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${task.timeline}시 작업 수정'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tec,
              decoration: const InputDecoration(
                labelText: '작업 내용',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(child: _DropDownWidgetConsumer()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              if (tec.text.isNotEmpty) {
                final updatedTask = task.copyWith(
                  title: tec.text.trim(),
                  taskType: ref.watch(currentTaskTypeProvider).currentType,
                  modifyTime: DateTime.now(),
                );
                addDoneTask(updatedTask);
                Navigator.of(context).pop();
              }
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  Future<void> todoListStream() async {
    final selectedDate = ref.watch(selectedHomeDateProvider);
    
    try {
      // TODO 작업 로드
      final todoTasks = await _loadTodoTasks(selectedDate);
      ref.readTodoHomeHolder.clear();
      for (var task in todoTasks) {
        ref.readTodoHomeHolder.addTodo(task);
      }

      // 완료된 작업 로드
      final doneTasks = await _loadDoneTasks(selectedDate);
      ref.readDoneHolder.clear();
      for (var task in doneTasks) {
        ref.readDoneHolder.addTodo(task);
      }
    } catch (e) {
      debugPrint('데이터 로드 오류: $e');
      // 에러 발생 시에도 기본 데이터는 유지
    }
  }

  Future<List<TodoTask>> _loadTodoTasks(DateTime selectedDate) async {
    try {
      final writtenTodoTasks = await TodoApi.instance.getTodoList(selectedDate);
      
      if (writtenTodoTasks.successData.docs.isEmpty) {
        // 빈 템플릿 생성
        return await RangeStream(0, 23).map((i) {
          return TodoTask(
            timeline: i,
            workDate: selectedDate.formattedDateOnly,
            createdTime: DateTime.now(),
            title: '',
            taskType: TaskType.nill,
            uid: ref.watch(userProvider).value!,
          );
        }).toList();
      } else {
        // 기존 데이터 로드
        final template = TodoTaskTemplate.fromJson(
          writtenTodoTasks.successData.docs.first.data()
        );
        return template.taskContents.map((ele) {
          final content = TodoContent.fromJson(ele);
          return TodoTask(
            workDate: selectedDate.formattedDateOnly,
            timeline: content.timeline,
            createdTime: DateTime.now(),
            title: content.title,
            taskType: content.taskType,
            uid: ref.watch(userProvider).value!,
          );
        }).toList();
      }
    } catch (e) {
      debugPrint('TODO 작업 로드 오류: $e');
      return [];
    }
  }

  Future<List<TodoTask>> _loadDoneTasks(DateTime selectedDate) async {
    try {
      final writtenDoneTasks = await TodoApi.instance.getDoneTodoList(selectedDate);
      
      final List<TodoTask> tempList = [];
      if (writtenDoneTasks.successData.docs.isNotEmpty) {
        tempList.addAll(writtenDoneTasks.successData.docs.map((ele) {
          TodoTask item = TodoTask.fromJson(ele.data());
          return item.copyWith(docId: ele.id);
        }).toList());
      }

      // 24시간 전체 리스트 생성
      return await RangeStream(0, 23).map((i) {
        final matchedTask = tempList.where((tmp) => tmp.timeline == i).toList();
        return matchedTask.isEmpty
            ? TodoTask(
                timeline: i,
                workDate: selectedDate.formattedDateOnly,
                createdTime: DateTime.now(),
                title: '',
                taskType: TaskType.nill,
                uid: ref.watch(userProvider).value!,
              )
            : matchedTask[0];
      }).toList();
    } catch (e) {
      debugPrint('완료된 작업 로드 오류: $e');
      return [];
    }
  }

  Future<void> addDoneTask(TodoTask todoTask) async {
    try {
      ref.readDoneHolder.updateTodo(todoTask);
      await TodoApi.instance.addDoneTask(todoTask);
    } catch (e) {
      debugPrint('작업 업데이트 오류: $e');
      // 에러가 발생해도 UI는 업데이트
    }
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectedHomeDateProvider),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      ref.readSelectHomeDateHolder.changeDate(DateUtils.dateOnly(date));
      await _loadInitialData();
    }
  }
}

class _DropDownWidgetConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentType = ref.watch(currentTaskTypeProvider).currentType;
    return DropdownButton(
      padding: const EdgeInsets.all(5),
      value: currentType,
      items: dropDownTaskType,
      onChanged: (value) {
        ref.watch(currentTaskTypeProvider.notifier).currentTypeOnChange(value);
      },
    );
  }
}
