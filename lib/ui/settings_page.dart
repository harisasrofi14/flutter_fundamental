import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/utils/custom_dialog.dart';
import 'package:restaurant_app/utils/string_resource.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class SettingPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: Text('Dark Theme'),
              trailing: Switch.adaptive(
                value: provider.isDarkTheme,
                onChanged: (value) => provider.enableDarkTheme(value),
              ),
            ),
          ),
          Material(
            child: ListTile(
              title: Text('Scheduling Reminder'),
              trailing: Consumer<PreferencesProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyReminderActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context, StringTranslation.comingSoonTitle,
                            StringTranslation.comingSoonDesc);
                      } else {
                        scheduled.scheduledRestaurant(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
