import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';

class PlatformDropDown extends StatelessWidget{
  final String labelText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String?>? validator;

  const PlatformDropDown({super.key, required this.labelText, this.value, required this.items, required this.onChanged, this.validator});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial){
      return _buildMaterialDropDown(context);
    } else {
      return _buildCupertinoPicker(context);
    }
  }

  Widget _buildMaterialDropDown(BuildContext context){
    return DropdownButtonFormField<String>(
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item)
        );
      }).toList(), 
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildCupertinoPicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.systemGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CupertinoButton(
            child: Text(value ?? labelText), 
            onPressed: () {
              showCupertinoModalPopup(
                context: context, 
                builder: (BuildContext context) => Container(
                  height: 200,
                  child: CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (int index) {
                      onChanged(items[index]);
                    },
                    children: items.map((item) => Text(item)).toList(),
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }
}