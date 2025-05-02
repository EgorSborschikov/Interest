import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

class PlatformProgressIndicator extends StatelessWidget{
  const PlatformProgressIndicator({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial){
      return CircularProgressIndicator();
    } else {
      return CupertinoActivityIndicator();
    }
  }
}