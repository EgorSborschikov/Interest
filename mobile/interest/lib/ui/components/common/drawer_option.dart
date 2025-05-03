import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget{
  final String title;
  final Widget child;
  final VoidCallback onTap;

  const DrawerOption({super.key, required this.title, required this.child, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface
        ),
      ),
      leading: child,
      onTap: onTap,
    );
  }
}