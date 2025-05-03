import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

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

    if (theme.isMaterial){
      return AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 26
          ),
        ),
        centerTitle: true,
        /*leading: SizedBox(
          width: 50,
          height: 50,
          child: child,
        ),*/
        actions: trailing,
      );
    } else {
      return CupertinoNavigationBar(
        backgroundColor: theme.colorScheme.surface,
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