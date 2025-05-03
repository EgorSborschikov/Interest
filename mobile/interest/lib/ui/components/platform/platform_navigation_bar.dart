import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_provider.dart';

class PlatformNavigationBar extends StatelessWidget{
  final Function(int index) onSelect;
  final List<BottomNavigationBarItem> items;
  final int currentIndex; 

  const PlatformNavigationBar({super.key, required this.onSelect, required this.items, required this.currentIndex});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (theme.isMaterial){
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkTheme ? Colors.black : Colors.white,
        items: items,
        currentIndex: currentIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.colorScheme.onSurface,
        onTap: onSelect,
      );
    } else {
      return CupertinoTabBar(
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkTheme ? Colors.black : Colors.white,
        items: items,
        currentIndex: currentIndex,
        activeColor: theme.primaryColor,
        inactiveColor: theme.colorScheme.onSurface,
        onTap: onSelect,
      );
    }
  }
}