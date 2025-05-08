import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:provider/provider.dart';
import '../../themes/theme_provider.dart';

///<summary>
/// Виджет определения и отображения нативной верхней панели приложения
///</summary>

class PlatformAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? child;
  final List<Widget>? trailing;

  const PlatformAppBar({super.key, required this.title, this.child, this.trailing});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (theme.isMaterial){
      return AppBar(
        backgroundColor: themeProvider.isDarkTheme 
          ? theme.colorScheme.tertiary
          : Colors.white,
        title: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 22
          ),
        ),
        centerTitle: true,
        /*leading: SizedBox(
          width: 50,
          height: 50,
          child: child,
        ),*/
        leading: child,
        actions: trailing,
        automaticallyImplyLeading: false,
      );
    } else {
      return CupertinoNavigationBar(
        backgroundColor: themeProvider.isDarkTheme 
          ? theme.colorScheme.tertiary
          : Colors.white,
        middle: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 26
          ),
        ),
        leading: child,
        automaticallyImplyLeading: false,
        trailing: trailing != null && trailing!.isNotEmpty
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: trailing!,
            )
          : null,
      );
    }
  }
  
  @override
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);
}