import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:provider/provider.dart';
import '../../themes/theme_provider.dart';

class PlatformSettingsOptionsTile extends StatelessWidget {
  final String title;
  final Widget child;

  const PlatformSettingsOptionsTile({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (theme.isMaterial) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 4
        ),
        child: Container(
          decoration: BoxDecoration(
            color: themeProvider.isDarkTheme 
              ? theme.colorScheme.tertiary
              : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ], 
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  //style: ,
                ),
                child,
              ],
            ),
          ),
        ),
      );
    } else {
      return CupertinoFormRow(
        prefix: Text(title),
        child: child,
      );
    }
  }
}