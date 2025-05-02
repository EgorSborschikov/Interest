import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';


class PlatformWarningElement extends StatelessWidget{
  final String title;
  final String content;

  const PlatformWarningElement({super.key, required this.title, required this.content});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if(theme.isMaterial) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              AppLocalizations.of(context)!.cancel
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              AppLocalizations.of(context)!.accept,
            ),
          ),
        ],
      );
    
    } else {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                color: theme.cupertinoAlertColor
              ),
            ),
          ),
          CupertinoDialogAction(
          isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
                },
            child: Text(
              AppLocalizations.of(context)!.accept,
              style: TextStyle(
                color: theme.cupertinoActionColor
              ),
            ),
          ),
        ],
      );
    }  
  }
}