import 'package:times_line/auth.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/fcm/fcm_manager.dart';
import 'package:times_line/common/route/fade_trasition_page.dart';
import 'package:times_line/common/theme/custom_theme_app.dart';
import 'package:times_line/common/widget/w_round_button.dart';
import 'package:times_line/screen/main/s_main.dart';
import 'package:times_line/screen/main/tab/tab_item.dart';
import 'package:times_line/screen/post_detail/s_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    FcmManager.requestPermission();
    FcmManager.initialize();
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
        path: '/',
        redirect: (_, __) => '/main',
      ),
      GoRoute(
        path: '/main',
        redirect: (_, __) => '/main/home',
      ),
      GoRoute(
        path: '/signin',
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
        path: '/productPost/:postId',
        redirect: (BuildContext context, GoRouterState state) =>
            '/main/home/${state.pathParameters['postId']}',
      ),
      GoRoute(
        path: '/main/:kind(home|localLife|nearMe|chat|my)',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            firstTab: TabItem.find(state.pathParameters['kind']),
          ),
        ),
        routes: [
          GoRoute(
            path: ':postId',
            builder: (context, state) {
              final postId = state.pathParameters['postId']!;
              print(postId);
              return PostDetailScreen(int.parse(postId));
            },
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            // 사용자 정의 셸을 구현하는 위젯을 반환합니다. (BottomNavigationBar)
            return SizedBox(
              height: 85,
              child: Container(
                height: bottomNavigationBarHeight,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(bottomNavigationBarBorderRadius),
                    topRight: Radius.circular(bottomNavigationBarBorderRadius),
                  ),
                  child: Scaffold(
                    bottomNavigationBar: BottomNavigationBar(
                      items: navigationBarItems(context),
                      selectedItemColor: context.appColors.text,
                      unselectedItemColor:
                          context.appColors.iconButtonInactivate,
                      onTap: (index) => navigationShell.goBranch(index),
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: navigationShell.currentIndex,

                    ),
                    body: navigationShell,

                  ),
                ),
              ),
            );
          },
          branches: <StatefulShellBranch>[
            // Tab A (First Tab)
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/home',
                  builder: (BuildContext context, GoRouterState state) =>
                      const MainScreen(firstTab: TabItem.home),
                ),
              ],
            ),
          ])
    ],
    redirect: _auth.guard,
    refreshListenable: _auth,
    debugLogDiagnostics: true,
  );
}
