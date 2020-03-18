import 'package:flutter/material.dart';

import 'database.dart';

class SettingsProvider with ChangeNotifier {
  DatabaseService _db = DatabaseService();

  /// dark mode settings
  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(k) {
    _darkMode = k;
    notifyListeners();
  }

  bool _enableNotification = true;
  bool get enableNotification => _enableNotification;
  set enableNotification(bool k) {
    print(k);
    if (k) {
      _db.subscribeToNotification('general');
    } else {
      _db.unsubscribeToNotification('general');
    }
    _enableNotification = k;
    notifyListeners();
  }
}
