import 'package:flutter/material.dart';
import 'package:interest/features/auth/widgets/language_selected_button.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///<summary>
///Экран регистрации
///</summary>

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Контроллеры данных
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PlatformAppBar(
        title: '', 
        child: LanguageSelectedButton()
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 80.0),
                Text(
                  AppLocalizations.of(context)!.signUp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 16.0),
                PlatformTextField(
                  label: AppLocalizations.of(context)!.email, 
                  controller: _emailController, 
                  placeholder: AppLocalizations.of(context)!.requeired, 
                  obscure: false,
                ),
                const SizedBox(height: 16.0),
                PlatformTextField(
                  label: AppLocalizations.of(context)!.password, 
                  controller: _passwordController, 
                  placeholder: AppLocalizations.of(context)!.requeired, 
                  obscure: _isObscure,
                  suffixIcon: GestureDetector(
                    onTap: _toggleObscure,
                    child: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                PlatformTextField(
                  label: AppLocalizations.of(context)!.confirmPassword, 
                  controller: _passwordConfirmController, 
                  placeholder: AppLocalizations.of(context)!.requeired, 
                  obscure: _isObscure,
                  suffixIcon: GestureDetector(
                    onTap: _toggleObscure,
                    child: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                PlatformButton(
                  text: AppLocalizations.of(context)!.createAccount, 
                  onTap: () {

                  }
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.iHaveAnAccount, 
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.logIn, 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }
}