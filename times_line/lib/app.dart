import 'package:times_line/auth.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/common/route/fade_trasition_page.dart';
import 'package:times_line/common/theme/custom_theme_app.dart';
import 'package:times_line/common/widget/w_round_button.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/dialog/d_message.dart';
import 'package:times_line/screen/main/s_main.dart';
import 'package:times_line/screen/main/tab/home/d_dialog_page.dart';
import 'package:times_line/screen/main/tab/home/d_write_task.dart';
import 'package:times_line/screen/main/tab/plan_template/write_plan_fragment.dart';
import 'package:times_line/screen/main/tab/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/screen/opensource/s_opensource.dart';

import 'common/theme/custom_theme.dart';

class App extends ConsumerStatefulWidget {
  ///light, dark 테마가 준비되었고, 시스템 테마를 따라가게 하려면 해당 필드를 제거 하시면 됩니다.
  static const defaultTheme = CustomTheme.dark;
  static bool isForeground = true;
  static final GlobalKey<ScaffoldMessengerState> scaffoldNavigationKey =
      GlobalKey();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with WidgetsBindingObserver {
  final _scaffoldKey = const ValueKey<String>('App scaffold');
  final _auth = DangnAuth();

  TabItem get _currentTab => ref.read(currentTabProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return ProviderScope(
          child: DangnAuthScope(
            notifier: _auth,
            child: MaterialApp.router(
              routerConfig: _router,
              scaffoldMessengerKey: App.scaffoldNavigationKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Image Finder',
              theme: context.themeType.themeData,
            ),
          ),
        );
      }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  final tabs = TabItem.values;
  late final List<GlobalKey<NavigatorState>> navigatorKeys =
      TabItem.values.map((e) => GlobalKey<NavigatorState>()).toList();

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 30.0;
  static const bottomNavigationBarHeight = 100.0;

  bool isFabExpanded = false;

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

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = App.scaffoldNavigationKey;
    }
  }

  late final GoRouter _router = GoRouter(
    initialLocation: '/main',
    routes: <RouteBase>[
      GoRoute(
        path: '/writeTask',
        name: 'writeTask',
        pageBuilder: (context, state) {
          return DialogPage(
              builder: (_) =>
                  WriteTaskDialog(todoTask: state.extra as TodoTask));
        },
      ),
      GoRoute(
        path: '/',
        name: 'home',
        redirect: (_, __) => '/main',
      ),
      GoRoute(
        path: '/main',
        name: 'name',
        redirect: (_, __) => '/main/home',
      ),
      GoRoute(
        path: '/signin',
        name: 'signin',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: Container(
            color: Colors.green,
            child: Center(
                child: RoundButton(
              text: '로그인',
              onTap: () {
                print('로그인');
                _auth.signIn('mermer', '1234');
                print(_auth.signedIn);
              },
            )),
          ),
        ),
      ),
      GoRoute(
        path: '/writePlan/:workDate',
          builder: (context, state) {
            final workDate = state.pathParameters['workDate']!;
            print('workDate:: $workDate');
            return WritePlanFragment(selectedData: workDate);
          }
      ),
      GoRoute(
        path: '/main/:kind(home|writePlan|nearMe|chat|my)',
        name: 'path',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            firstTab: TabItem.find(state.pathParameters['kind']),
          ),
        ),
      ),
    ],
    redirect: _auth.guard,
    refreshListenable: _auth,
    debugLogDiagnostics: true,
  );
}
