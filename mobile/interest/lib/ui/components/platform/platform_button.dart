import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

///<summary>
/// Виджет определения и отображения нативной кнопки
///</summary>

class PlatformButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;

  const PlatformButton({super.key, required this.text, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial){
      return ElevatedButton(
        onPressed: onTap, 
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor, 
          padding: EdgeInsets.symmetric(horizontal: 43, vertical: 10), 
          minimumSize: Size(263, 43), 
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white
          ),
        ),
      );
    } else {
      return CupertinoButton(
        onPressed: onTap,
        padding: EdgeInsets.symmetric(),
        color: theme.primaryColor,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white,
          ),
        )
      );
    }
  }
}
