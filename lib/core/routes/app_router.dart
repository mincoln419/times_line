import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/presentation/screens/home_screen.dart';
import 'package:times_line/presentation/screens/diary_screen.dart';
import 'package:times_line/presentation/screens/template_screen.dart';
import 'package:times_line/presentation/screens/template_detail_screen.dart';
import 'package:times_line/presentation/screens/template_edit_screen.dart';
import 'package:times_line/presentation/screens/statistics_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavigation(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/diary',
          name: 'diary',
          builder: (context, state) => const DiaryScreen(),
        ),
        GoRoute(
          path: '/template',
          name: 'template',
          builder: (context, state) => const TemplateScreen(),
        ),
        GoRoute(
          path: '/template/new',
          name: 'template-new',
          builder: (context, state) {
            print('=== 라우터: /template/new 경로 호출됨 ===');
            return const TemplateEditScreen();
          },
        ),
        GoRoute(
          path: '/template/edit/:id',
          name: 'template-edit',
          builder: (context, state) {
            final templateId = state.pathParameters['id']!;
            print('=== 라우터: /template/edit/$templateId 경로 호출됨 ===');
            return TemplateEditScreen(templateId: templateId);
          },
        ),
        GoRoute(
          path: '/template/:id',
          name: 'template-detail',
          builder: (context, state) {
            final templateId = state.pathParameters['id']!;
            return TemplateDetailScreen(templateId: templateId);
          },
        ),
        GoRoute(
          path: '/statistics',
          name: 'statistics',
          builder: (context, state) => const StatisticsScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavigation extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.book), label: '일기'),
          NavigationDestination(icon: Icon(Icons.dashboard), label: '템플릿'),
          NavigationDestination(icon: Icon(Icons.analytics), label: '통계'),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/diary');
              break;
            case 2:
              context.go('/template');
              break;
            case 3:
              context.go('/statistics');
              break;
          }
        },
        selectedIndex: _getSelectedIndex(context),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 0;
      case '/diary':
        return 1;
      case '/template':
        return 2;
      case '/statistics':
        return 3;
      default:
        return 0;
    }
  }
}
