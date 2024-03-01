import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
  CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;
  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    // Router initialization happens here.
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
    key: state.pageKey,
    child: child,
    );
  }
}

