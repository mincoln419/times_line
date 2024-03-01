// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// A mock authentication service
class DangnAuth extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  String? guard(BuildContext context, GoRouterState state) {
    final signedIn = this.signedIn;
    final signingIn = state.matchedLocation == '/signin';

    // Go to /signin if the user is not signed in
    if (!signedIn && !signingIn) {
      return '/signin';
    }
    // Go to /books if the user is signed in and tries to go to /signin.
    else if (signedIn && signingIn) {
      return '/';
    }

    // no redirect
    return null;
  }

}

class DangnAuthScope extends InheritedNotifier<DangnAuth> {
  const DangnAuthScope({
    required DangnAuth notifier,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: notifier, child: child);

  static DangnAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DangnAuthScope>()!
      .notifier!;
}