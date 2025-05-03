import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interest/ui/components/common/drawer_option.dart';
import 'package:interest/ui/themes/themes.dart';

import '../../../features/settings/settings.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Text(
                AppLocalizations.of(context)!.otherOptions,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20, 
                ),
              ),
              const SizedBox(height: 20.0),
              DrawerOption(
                title: AppLocalizations.of(context)!.favorites, 
                onTap: () {

                },
                child: theme.isMaterial
                  ? Icon(Icons.favorite)
                  : Icon(CupertinoIcons.heart), 
              ),
              const SizedBox(height: 16.0),
              DrawerOption(
                title: AppLocalizations.of(context)!.notifications, 
                onTap: () {

                },
                child: Icon(CupertinoIcons.bell), 
              ),
              const SizedBox(height: 16.0),
              DrawerOption(
                title: AppLocalizations.of(context)!.settings,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                child: theme.isMaterial
                    ? Icon(CupertinoIcons.gear_alt)
                    : Icon(CupertinoIcons.settings_solid),
              ),
              const SizedBox(height: 16.0),
              DrawerOption(
                title: AppLocalizations.of(context)!.logs,
                onTap: () {
                  
                },
                child: theme.isMaterial
                    ? Icon(Icons.list_alt_rounded)
                    : Icon(CupertinoIcons.bubble_right),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}