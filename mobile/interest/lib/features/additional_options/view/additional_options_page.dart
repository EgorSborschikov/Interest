import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/components/common/additional_options_tile.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../settings/settings.dart';

class AdditionalOptionsPage extends StatelessWidget{
  const AdditionalOptionsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final talker = TalkerFlutter.init();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.otherOptions
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              AdditionalOptionsTile(
                title: AppLocalizations.of(context)!.favorites, 
                onTap: () {

                },
                child: theme.isMaterial
                  ? Icon(Icons.favorite)
                  : Icon(CupertinoIcons.heart), 
              ),
              const SizedBox(height: 16.0),
              AdditionalOptionsTile(
                title: AppLocalizations.of(context)!.notifications, 
                onTap: () {

                },
                child: Icon(CupertinoIcons.bell), 
              ),
              const SizedBox(height: 16.0),
              AdditionalOptionsTile(
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
              AdditionalOptionsTile(
                title: AppLocalizations.of(context)!.logs,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TalkerScreen(
                        talker: talker,
                        appBarTitle: AppLocalizations.of(context)!.logs,
                        theme: TalkerScreenTheme(
                          backgroundColor: theme.colorScheme.surface,
                          textColor: theme.colorScheme.onSurface,
                        )
                      ),
                    ),
                  );
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