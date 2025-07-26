import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/core/theme/app_theme.dart';
import 'package:times_line/core/routes/app_router.dart';
import 'package:times_line/data/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 데이터베이스 초기화
  await DatabaseService.initialize();

  // 초기 데이터 생성
  await DatabaseService.createInitialData();

  // 오늘 날짜의 일일 태스크가 없으면 기본 템플릿으로 생성
  await DatabaseService.ensureTodayTasks();

  runApp(const ProviderScope(child: TimesLineApp()));
}

class TimesLineApp extends StatelessWidget {
  const TimesLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Times Line',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
