import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlatformSearchTextField extends StatefulWidget{
  final TextEditingController controller;
  final ValueChanged<String?> onSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onClearTap; 

  const PlatformSearchTextField({super.key, required this.controller, required this.onSubmitted, this.onEditingComplete, this.onClearTap});

  @override
  State<PlatformSearchTextField> createState() => _PlatformSearchTextFieldState();
}

class _PlatformSearchTextFieldState extends State<PlatformSearchTextField> {
  var _showSuffix = false;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      onFocusChange: (value) => _onFocusChanged(value),
      child: theme.isMaterial
        ? Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2)
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  textInputAction: TextInputAction.search,
                  onSubmitted: widget.onSubmitted,
                  onEditingComplete: widget.onEditingComplete,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchOnNickname,
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    suffixIcon: _showSuffix
                      ? IconButton(
                          onPressed: _clearText, 
                          icon: Icon(Icons.close, size: 22),
                        ) : null 
                  ),
                ),
              ),
            ],
          ),
        )
        : CupertinoSearchTextField(
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            placeholder: AppLocalizations.of(context)!.searchOnNickname,
            placeholderStyle: TextStyle(
              color: CupertinoColors.label,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(CupertinoIcons.search),
            suffixIcon: Icon(CupertinoIcons.clear_thick),
            onSuffixTap: () {
              widget.controller.clear();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            suffixMode: OverlayVisibilityMode.editing,
          ),
    );
  }

  void _clearText(){
    widget.controller.clear();
    widget.onClearTap?.call();
  }

  void _onFocusChanged(bool value){
    if (!value && widget.controller.text.isNotEmpty){
      return;
    }
    setState(() => _showSuffix = value);
  }
}