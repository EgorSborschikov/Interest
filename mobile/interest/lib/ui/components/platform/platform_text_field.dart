import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

///<summary>
/// Виджет определения и отображения нативного поля ввода
///</summary>

class PlatformTextField extends StatelessWidget{
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffixIcon;

  const PlatformTextField({
      super.key, 
      required this.label, 
      required this.controller, 
      required this.placeholder, 
      required this.obscure, 
      this.suffixIcon
    }
  );
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial){
      return TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          fillColor: Colors.white70,
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: theme.colorScheme.onSurface
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), 
            borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), 
            borderRadius: BorderRadius.circular(10)
          ),
          suffixIcon: suffixIcon,
        ),
      );
    } else {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: CupertinoTextField(
          prefix: Padding(
            padding: const EdgeInsets.only(left: 12), 
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          placeholder: placeholder,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), 
          decoration: const BoxDecoration(),
          obscureText: obscure,
          suffix: Padding(
            padding: const EdgeInsets.only(right: 12), 
            child: suffixIcon,
          ),
        ),
      );
    }
  }
}
