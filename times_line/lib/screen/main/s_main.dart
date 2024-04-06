import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_editor_provider.dart';
import 'package:times_line/screen/main/tab/tab_item.dart';
import 'package:times_line/screen/main/tab/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../common/common.dart';
import '../../entity/todo_task/task_type.dart';
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
                    final user = ref.watch(userCredentialProvider);
                    return FloatingActionButton(
                      child: const Icon(Icons.note_add_outlined),
                      onPressed: () {
                        final uid = user?.user?.uid;
                        print('uid: $uid');
                        if (uid == null) {
                          return;
                        }
                        context.go("/cart/$uid");
                      },
                    );
                  }),
                0 => FloatingActionButton(
                    child: const Icon(Icons.save),
                    onPressed: () async {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => const PlanAddScreen())
                      // )
                      List<TodoTask> todayTask =  ref.watch(todolistProvider);
                      final todoModel =
                          FirebaseFirestore.instance.collection("todoTask");
                      final tmp = await todoModel.get();

                      for (var ele in tmp.docs) {
                        await ele.reference.delete();
                      }
                      List<TextEditingController> tecList =  ref.watch(tecListProvider);
                      List<TodoTask> tmpTodos = [];
                      tmpTodos.addAll( ref.watch(todolistProvider));
                      ref.readTodoHolder.clear();
                      await RangeStream(0, 23).map((i) {
                        TodoTask todoTask = tmpTodos.length > i ? tmpTodos[i].copyWith():
                        TodoTask(
                          id: uuid.v1(),
                          timeline: i,
                          workDate: DateUtils.dateOnly(DateTime.now()),
                          createdTime: DateTime.now(),
                          title: '',
                          taskType: TaskType.nill,
                        );

                        todoTask.title = tecList[i].text;
                        todoModel.add(todoTask.toJson());
                        ref.readTodoHolder.addTodo(todoTask);
                        return todoTask;
                      }).forEach((ele) {
                        print(ele);
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                int() => null,
              },
            ),
          ],
        ),
      ),
    );
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
      height: 85,
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
