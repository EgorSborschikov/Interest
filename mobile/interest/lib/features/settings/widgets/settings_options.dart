import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:provider/provider.dart';
import '../../../ui/themes/theme_provider.dart';

class SettingsOptions extends StatelessWidget{
  const SettingsOptions({super.key});
  
  /*void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.inviteUsers)),
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text(
          AppLocalizations.of(context)!.personalization,
          style: TextStyle(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        const SizedBox(height: 16.0),
        PlatformSettingsOptionsTile(
          title: AppLocalizations.of(context)!.darkTheme, 
          child: PlatformSwitch(
            value: Provider.of<ThemeProvider>(context).isDarkTheme,
            onChanged: (value) { 
              Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(bool, value);
            },
          ),
        ),
        const SizedBox(height: 16.0),
        PlatformSettingsOptionsTile(
          title: AppLocalizations.of(context)!.languageInterface, 
          child: PlatformLanguageDrop()
        ),
        const SizedBox(height: 16.0),
        PlatformSettingsOptionsTile(
          title: AppLocalizations.of(context)!.allowNotify, 
          child: PlatformSwitch(
            value: true,
            onChanged: (value) { 
              
            },
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          AppLocalizations.of(context)!.additionalTerms,
          style: TextStyle(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        const SizedBox(height: 16.0),
        PlatformSettingsOptionsTile(
          title: AppLocalizations.of(context)!.inviteUsers, 
          child: IconButton(
            onPressed: () {

            }, 
            icon: Icon(CupertinoIcons.link),
          ),
        ),
        const SizedBox(height: 16.0),
        PlatformSettingsOptionsTile(
          title: AppLocalizations.of(context)!.technicalSupports, 
          child: IconButton(
            onPressed: () {

            }, 
            icon: Icon(
              Icons.telegram,
              color: theme.primaryColor,
            )
          ), 
        ),
        const SizedBox(height: 16.0),
        PlatformSettingsOptionsTile(
          title: AppLocalizations.of(context)!.deleteAccount, 
          child: IconButton(
            onPressed: () {

            }, 
            icon: Icon(
              CupertinoIcons.delete,
              color: theme.cupertinoAlertColor,
            )
          ), 
        ),
      ],
    );
  }
}