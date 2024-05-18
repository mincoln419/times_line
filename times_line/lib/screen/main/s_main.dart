import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/todo_task_template.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_home_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_editor_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_template_provider.dart';
import 'package:times_line/screen/main/tab/tab_item.dart';
import 'package:times_line/screen/main/tab/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../app.dart';
import '../../common/common.dart';
import '../../data/network/todo_template_api.dart';
import '../../data/simple_result.dart';
import '../../entity/todo_task/task_type.dart';
import '../../entity/todo_task/todo_task_template_sample.dart';
import '../dialog/d_confirm.dart';
import '../dialog/d_message.dart';
import '../login/provider/login_provider.dart';
import 'w_menu_drawer.dart';

final currentTabProvider = StateProvider((ref) => TabItem.home);

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    super.key,
    required this.firstTab,
  });

  final TabItem firstTab;

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  TabItem get _currentTab => ref.read(currentTabProvider);
  final tabs = TabItem.values;
  late final List<GlobalKey<NavigatorState>> navigatorKeys =
      TabItem.values.map((e) => GlobalKey<NavigatorState>()).toList();

  int get _currentIndex => tabs.indexOf(_currentTab);

  GlobalKey<NavigatorState> get _currentTabNavigationKey =>
      navigatorKeys[_currentIndex];

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 30.0;
  static const bottomNavigationBarHeight = 100.0;

  bool isFabExpanded = false;

  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    delay(() {
      ref.read(currentTabProvider.notifier).state = oldWidget.firstTab;
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Material(
        child: Stack(
          children: [
            Scaffold(
              extendBody: extendBody,
              //bottomNavigationBar 아래 영역 까지 그림
              drawer: const MenuDrawer(),
              body: Container(
                padding: EdgeInsets.only(
                    bottom:
                        extendBody ? 60 - bottomNavigationBarBorderRadius : 0),
                child: SafeArea(
                  bottom: !extendBody,
                  child: pages,
                ),
              ),
              bottomNavigationBar: _buildBottomNavigationBar(context),
              floatingActionButton: switch (_currentIndex) {
                2 => Consumer(builder: (context, ref, child) {
                    final user = ref.watch(userProvider);
                    return FloatingActionButton(
                      child: const Icon(Icons.note_add_outlined),
                      onPressed: () {
                        final uid = user.value;
                        print('uid: $uid');
                        if (uid == null) {
                          return;
                        }
                        context.go("/cart/$uid");
                      },
                    );
                  }),
                0 => Stack(
                    children: [
                      Align(
                        alignment: Alignment(Alignment.bottomRight.x,
                            Alignment.bottomRight.y - 0.2),
                        child: FloatingActionButton(
                          onPressed: () async {
                            final result = await showDialog<SimpleResult>(
                                context: context,
                                builder: (context) {
                                  return ConfirmDialog(
                                    '초기화 하시겠습니까',
                                    buttonText: 'Yes',
                                    cancelButtonText: 'No',
                                  );
                                });

                            if (result!.isFailure) return;

                            bothTodoListInit();
                            final selectedDate =
                                ref.watch(selectedDateProvider);
                            CollectionReference<Map<String, dynamic>> db =
                                FirebaseFirestore.instance
                                    .collection("todoTask");
                            final dbListJson = await db
                                .where('workDate',
                                    isEqualTo: selectedDate.formattedDateOnly)
                                .get()
                                .then((value) => value.docs.isNotEmpty
                                    ? value.docs.first.data()
                                    : null);
                            if (dbListJson == null) {
                              return;
                            }
                            final dbList = TodoTaskTemplate.fromJson(dbListJson)
                                .taskContents
                                .map((e) => TodoContent.fromJson(e))
                                .toList()
                                .map(
                                  (tc) => TodoTask(
                                    workDate: selectedDate.formattedDateOnly,
                                    timeline: tc.timeline,
                                    title: tc.title,
                                    taskType: tc.taskType,
                                    uid: ref.watch(userProvider).value!,
                                  ),
                                )
                                .toList();
                            List<TodoContent> todoContents =
                                await RangeStream(0, 23).map(
                              (i) {
                                final newText = dbList[i].title;
                                TodoContent todoTask =
                                    todoContentFromTodoTask(dbList, i, newText);
                                todoListTemplateRefresh(selectedDate, todoTask);
                                return todoTask;
                              },
                            ).toList();
                          },
                          tooltip: '초기화',
                          child: const Icon(Icons.refresh_sharp),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          child: const Icon(Icons.save),
                          onPressed: () async {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => const PlanAddScreen())
                            // )
                            final selectedDate =
                                ref.watch(selectedDateProvider);
                            CollectionReference<Map<String, dynamic>> db =
                                FirebaseFirestore.instance
                                    .collection("todoTask");
                            final docId = await db
                                .where('workDate',
                                    isEqualTo: selectedDate.formattedDateOnly)
                                .get()
                                .then((value) => value.docs.isNotEmpty
                                    ? value.docs[0].id
                                    : null);
                            // 상태관리 처리
                            List<TextEditingController> tecList =
                                ref.watch(tecListProvider);
                            print("tecList: ${tecList.length}");
                            List<TodoTask> tmpTodos = [];
                            tmpTodos.addAll(ref
                                .watch(todolistProvider)
                                .map((e) => e.copyWith()));
                            bothTodoListInit();

                            List<TodoContent> todoContents =
                                await RangeStream(0, 23).map(
                              (i) {
                                final newText = tecList[i].text;
                                TodoContent todoTask = todoContentFromTodoTask(
                                    tmpTodos, i, newText);
                                todoListTemplateRefresh(selectedDate, todoTask);
                                return todoTask;
                              },
                            ).toList();

                            //데이터 적재처리
                            if (docId == null) {
                              db.add(TodoTaskTemplate(
                                workDate: selectedDate.formattedDateOnly,
                                uid: 'abc',
                                modifyTime: DateTime.now(),
                                createdTime: DateTime.now(),
                                taskContents: todoContents
                                    .map((e) => e.toJson())
                                    .toList(),
                              ).toJson());
                            } else {
                              db.doc(docId).update(TodoTaskTemplate(
                                    workDate: selectedDate.formattedDateOnly,
                                    modifyTime: DateTime.now(),
                                    taskContents: todoContents
                                        .map((e) => e.toJson())
                                        .toList(),
                                  ).toJson());
                            }

                            /* TODO 샘플 템플릿 리스트 최신화 -> 공통 모듈로 refactoring 필요*/
                            // now 데이터 db 갱신
                            final template = TodoTaskTemplateSample(
                                templateName: "now",
                                uid: "abc",
                                createdTime: DateTime.now(),
                                orderSort: 0,
                                taskContents: todoContents
                                    .map((e) => TodoTask(
                                        uid: 'abc',
                                        workDate: selectedDate.formattedDateOnly,
                                        title: e.title,
                                        taskType: e.taskType).toJson())
                                    .toList());

                            final result = await TodoTemplateApi.instance
                                .removeTemplateByName(template.templateName!);
                            if (result.isSuccess) {
                              TodoTemplateApi.instance
                                  .addTodoTemplate(template);
                            }
                            print(
                                "template저장?:: + ${template.taskContents[0]}");

                            final tdb = FirebaseFirestore.instance
                                .collection("todoTemplate");
                            final uid = ref.watch(userProvider);
                            final tresult = await tdb
                                .where('uid', isEqualTo: uid.value)
                                .orderBy("orderSort")
                                .get();

                            final templates = ref.readTemplateSampleHolder;
                            templates.clear();
                            for (var element in tresult.docs) {
                              final sample = TodoTaskTemplateSample.fromJson(
                                  element.data());
                              templates.addTodo(sample);
                            }
                            print(
                                "templates:: + ${templates.state[0].taskContents[0]}");

                            showDialog<SimpleResult>(
                                builder: (context) {
                                  if (context.mounted) {
                                    return MessageDialog('저장되었습니다',
                                        buttonText: '확인');
                                  }
                                  return const CircularProgressIndicator();
                                },
                                context:
                                    App.navigatorKey.currentContext ?? context);

                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                int() => null,
              },
            ),
          ],
        ),
      ),
    );
  }

  void bothTodoListInit() {
    ref.readTodoHolder.clear();
    ref.readTodoHomeHolder.clear();
  }

  void todoListTemplateRefresh(DateTime selectedDate, TodoContent todoTask) {
    final addTodo = TodoTask(
      workDate: selectedDate.formattedDateOnly,
      createdTime: DateTime.now(),
      modifyTime: DateTime.now(),
      timeline: todoTask.timeline,
      title: todoTask.title,
      taskType: todoTask.taskType,
      uid: ref.watch(userProvider).value!,
    );
    ref.readTodoHolder.addTodo(addTodo);
    ref.readTodoHomeHolder.addTodo(addTodo);
  }

  TodoContent todoContentFromTodoTask(
      List<TodoTask> tmpTodos, int i, String newText) {
    TodoContent todoTask = tmpTodos.length > i
        ? TodoContent(
            title: newText,
            timeline: tmpTodos[i].copyWith().timeline,
            taskType: tmpTodos[i].copyWith().taskType,
          )
        : TodoContent(
            timeline: i,
            title: '',
            taskType: TaskType.nill,
          );
    return todoTask;
  }

  IndexedStack get pages => IndexedStack(
      index: _currentIndex,
      children: tabs
          .mapIndexed((tab, index) => Offstage(
                offstage: _currentTab != tab,
                child: TabNavigator(
                  navigatorKey: navigatorKeys[index],
                  tabItem: tab,
                ),
              ))
          .toList());

  Future<bool> _handleBackPressed() async {
    final isFirstRouteInCurrentTab =
        (await _currentTabNavigationKey.currentState?.maybePop() == false);
    if (isFirstRouteInCurrentTab) {
      if (_currentTab != TabItem.home) {
        _changeTab(tabs.indexOf(TabItem.home));
        return false;
      }
    }
    // maybePop 가능하면 나가지 않는다.
    return isFirstRouteInCurrentTab;
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      height: bottomNavigationBarHeight - 3,
      child: Container(
        height: bottomNavigationBarHeight,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(bottomNavigationBarBorderRadius),
            topRight: Radius.circular(bottomNavigationBarBorderRadius),
          ),
          child: BottomNavigationBar(
            items: navigationBarItems(context),
            currentIndex: _currentIndex,
            selectedItemColor: context.appColors.text,
            unselectedItemColor: context.appColors.iconButtonInactivate,
            onTap: _handleOnTapNavigationBarItem,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
    final currentTab = ref.watch(currentTabProvider);
    final currentIndex = tabs.indexOf(currentTab);
    return tabs
        .mapIndexed(
          (tab, index) => tab.toNavigationBarItem(
            context,
            isActivated: currentIndex == index,
          ),
        )
        .toList();
  }

  void _changeTab(int index) {
    ref.read(currentTabProvider.notifier).state = tabs[index];
    FocusManager.instance.primaryFocus?.unfocus();
  }

  BottomNavigationBarItem bottomItem(bool activate, IconData iconData,
      IconData inActivateIconData, String label) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(label),
          activate ? iconData : inActivateIconData,
          color: activate
              ? context.appColors.iconButton
              : context.appColors.iconButtonInactivate,
        ),
        label: label);
  }

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = _currentTabNavigationKey;
      popAllHistory(navigationKey);
    }
    _changeTab(index);
  }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }
}
