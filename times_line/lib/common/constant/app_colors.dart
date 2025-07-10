import 'package:flutter/material.dart';

class AppColors {
  // 미니멀리즘 블루 톤 색상 팔레트
  static const Color primaryBlue = Color(0xFF2563EB); // 메인 블루
  static const Color lightBlue = Color(0xFF3B82F6); // 밝은 블루
  static const Color darkBlue = Color(0xFF1E40AF); // 어두운 블루
  static const Color accentBlue = Color(0xFF60A5FA); // 액센트 블루
  static const Color subtleBlue = Color(0xFFDBEAFE); // 미묘한 블루
  
  // 그레이 톤 (미니멀리즘)
  static const Color veryDarkGrey = Color(0xFF111827);
  static const Color darkGrey = Color(0xFF374151);
  static const Color grey = Color(0xFF6B7280);
  static const Color middleGrey = Color(0xFF9CA3AF);
  static const Color brightGrey = Color(0xFFF3F4F6);
  static const Color lightGrey = Color(0xFFF9FAFB);
  
  // 기존 호환성을 위한 별칭
  static const Color blueGreen = accentBlue;
  static const Color green = Color(0xFF10B981); // 에메랄드 그린
  static const Color darkGreen = Color(0xFF059669);
  static const Color blue = primaryBlue;
  static const Color mediumBlue = lightBlue;
  static const Color darkOrange = Color(0xFFF59E0B); // 앰버 오렌지
  static const Color faleBlue = subtleBlue;
  static const Color brightBlue = accentBlue;
  static const Color salmon = Color(0xFFEF4444); // 레드
}
