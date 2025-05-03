import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/features/home/home.dart';
import 'package:interest/features/settings/widgets/settings_options.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interest/ui/themes/themes.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.settings, 
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }, 
          icon: theme.isMaterial 
            ? Icon(Icons.arrow_back) 
            : Icon(CupertinoIcons.back)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SettingsOptions(),
          ),
        ),
      ),
    );
  }
}