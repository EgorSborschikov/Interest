import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/features/profile/profile.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interest/ui/themes/themes.dart';

class ProfileViewPage extends StatelessWidget{
  const ProfileViewPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.profileData,
        trailing: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ProfileEditPage()
                ),
              );
            },
            icon: theme.isMaterial 
              ? Icon(Icons.edit, color: theme.colorScheme.onSurface)
              : Icon(CupertinoIcons.pencil, color: theme.colorScheme.onSurface)
          ),
        ],
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: theme.isMaterial
            ? Icon(Icons.arrow_back_rounded, color: theme.colorScheme.onSurface, size: 26)
            : Icon(CupertinoIcons.back, color: theme.cupertinoActionColor, size: 26)
        ),
      ),
    );
  }
}