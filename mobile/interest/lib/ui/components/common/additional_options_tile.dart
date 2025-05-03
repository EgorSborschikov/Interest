import 'package:flutter/material.dart';

class AdditionalOptionsTile extends StatelessWidget{
  final String title;
  final Widget child;
  final VoidCallback onTap;

  const AdditionalOptionsTile({super.key, required this.title, required this.child, required this.onTap});
  
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