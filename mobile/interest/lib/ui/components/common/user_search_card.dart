import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

class UserSearchCard extends StatelessWidget{
  const UserSearchCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Nickname'),
          IconButton(
            onPressed: () {

            }, 
            icon: theme.isMaterial
              ? Icon(
                  Icons.arrow_forward_ios_rounded, 
                  color: theme.colorScheme.onSurface)
              : Icon(
                  CupertinoIcons.chevron_right, 
                  color: theme.colorScheme.onSurface)
          ),
        ],
      ),
    );
  }
}