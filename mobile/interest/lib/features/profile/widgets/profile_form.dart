import 'package:flutter/material.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _nicknameController = TextEditingController();
  final FocusNode _nicknameFocusNode = FocusNode();

  final TextEditingController _birthDayController = TextEditingController();
  final FocusNode _birthDayFocusNode = FocusNode();

  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  String? _selectedGoal;
  List<String> _interests = [];

  List<String> _goals = [];
  List<String> _allInterests = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                children: [
                  PlatformTextField(
                    label: AppLocalizations.of(context)!.nickname,
                    controller: _nicknameController,
                    placeholder: '',
                    obscure: false,
                    focusNode: _nicknameFocusNode,
                  ),
                  const SizedBox(height: 12.0),
                  PlatformTextField(
                    label: AppLocalizations.of(context)!.birthDay,
                    controller: _birthDayController,
                    placeholder: '',
                    obscure: false,
                    focusNode: _birthDayFocusNode,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Text(
          AppLocalizations.of(context)!.additionalInfo,
          style: TextStyle(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16.0),
        PlatformTextField(
          label: AppLocalizations.of(context)!.phoneNumber,
          controller: _phoneNumberController,
          placeholder: '',
          obscure: false,
          focusNode: _phoneNumberFocusNode,
        ),
        const SizedBox(height: 16.0),
        PlatformDropDown(
          labelText: AppLocalizations.of(context)!.purposeOfDating,
          value: _selectedGoal,
          items: _goals,
          onChanged: (value) {
            setState(() {
              _selectedGoal = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.error;
            }
            return null;
          },
        ),
      ],
    );
  }
}
