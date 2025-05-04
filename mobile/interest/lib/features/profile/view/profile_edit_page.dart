import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/features/profile/widgets/profile_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../ui/components/platform/platform.dart';

class ProfileEditPage extends StatelessWidget{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.editProfile,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.chevron_left_circle_fill,
            size: 36,
            color: theme.colorScheme.onSurface,
          ),
        ),
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