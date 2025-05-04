import 'package:flutter/material.dart';
import 'package:interest/features/settings/widgets/settings_options.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.settings, 
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