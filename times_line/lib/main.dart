import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/route/custom_router_helper.dart';
import 'package:times_line/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';
import 'package:camera/camera.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();

  // Firebase 초기화 (한 번만)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 카메라 초기화
  cameras = await availableCameras();

  // 디버그 모드에서 에뮬레이터 사용
  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
      FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);
      FirebaseStorage.instance.useStorageEmulator('10.0.2.2', 9199);
      print('Firebase 에뮬레이터 연결 성공');
    } catch (e) {
      print('Firebase 에뮬레이터 연결 실패: $e');
    }
  }

  setLocaleMessages('ko', KoMessages());
  CustomNavigationHelper.instance;
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ko')],
        fallbackLocale: const Locale('en'),
        path: 'assets/translations',
        useOnlyLangCode: true,
        child: const App(),
      ),
    ),
  );
}
