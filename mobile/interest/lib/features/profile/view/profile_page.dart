import 'package:flutter/material.dart';
import 'package:interest/features/profile/widgets/profile_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../ui/components/platform/platform.dart';

class ProfilePage extends StatelessWidget{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.profile,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Используйте Expanded для ограничения высоты
              Expanded(
                child: SingleChildScrollView(
                  child: ProfileForm(), // Убедитесь, что ProfileForm добавлен здесь
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}