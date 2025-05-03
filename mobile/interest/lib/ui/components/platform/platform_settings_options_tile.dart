import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

class PlatformSettingsOptionsTile extends StatelessWidget{
  final String title;
  final Widget child;
  const PlatformSettingsOptionsTile({super.key, required this.title, required this.child});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial){
      return ListTile(
        title: Flexible(
          child: Text(title)
        ),
        trailing: child,
      );
    } else {
      return CupertinoFormRow(
        prefix: Text(title),
        child: child
      );
    }
  }
}