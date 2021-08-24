import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;
  bool _isDailyReminderActive = false;

  bool get isDailyReminderActive => _isDailyReminderActive;

  PreferencesHelper preferencesHelper;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyReminder();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isDailyReminderActive = value;
    if (_isDailyReminderActive) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyReminder() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    notifyListeners();
  }
}
