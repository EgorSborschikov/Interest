import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:provider/provider.dart';
import '../../../l10n/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///<summary>
/// Виджет определения и отображения нативного переключателя языка для экранов регистрации и авторизации
///</summary>

class LanguageSelectedButton extends StatefulWidget{
  const LanguageSelectedButton({super.key});

  @override
  State<LanguageSelectedButton> createState() => _LanguageSelectedButtonState();
}

class _LanguageSelectedButtonState extends State<LanguageSelectedButton> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    _selectedLanguage = localeProvider.locale.languageCode == 'en' ? 'English' : 'Русский';

    if (theme.isMaterial) {
      return _buildAndroidPopupMenu(context);
    } else {
      return _buildCupertinoContextMenu(context);
    }
  }

  Widget _buildAndroidPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String result) {
        _onLanguageSelected(result);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'English',
            child: Text('English'),
          ),
          PopupMenuItem<String>(
            value: 'Русский',
            child: Text('Русский'),
          ),
        ];
      },
    );
  }

  Widget _buildCupertinoContextMenu(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _selectedLanguage,
            style: TextStyle(color: CupertinoColors.black),
          ),
          const SizedBox(width: 8.0),
          const Icon(
            CupertinoIcons.globe,
            color: CupertinoColors.inactiveGray,
          ),
        ],
      ),
      onPressed: () {
        // Show context menu
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  'English',
                  style: TextStyle(
                    color: theme.cupertinoActionColor
                  ),
                ),
                onPressed: () {
                  _onLanguageSelected('English');
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Русский',
                  style: TextStyle(
                    color: theme.cupertinoActionColor
                  ),
                ),
                onPressed: () {
                  _onLanguageSelected('Русский');
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: theme.cupertinoAlertColor
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _onLanguageSelected(String selectedLanguage) {
    setState(() {
      _selectedLanguage = selectedLanguage;
    });

    // Обновление локали в LocaleProvider и сохранение предпочтений
    if (selectedLanguage == 'English') {
      Provider.of<LocaleProvider>(context, listen: false).switchToEnglish();
      Provider.of<LocaleProvider>(context, listen: false).saveLanguagePreference('en');
    } else {
      Provider.of<LocaleProvider>(context, listen: false).switchToRussian();
      Provider.of<LocaleProvider>(context, listen: false).saveLanguagePreference('ru');
    }
  }
}