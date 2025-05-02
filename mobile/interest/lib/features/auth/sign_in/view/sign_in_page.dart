import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/features/auth/widgets/language_selected_button.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../services/supabase/auth_service.dart';
import '../../../home/view/home_page.dart';
import '../../sign_up/view/sign_up_page.dart';

///<summary>
///Экран регистрации
///</summary>

class SignInPage extends StatefulWidget{
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignInPage> {
  //Контроллеры данных
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final authService = AuthService();

  bool _isObscure = true;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await authService.signInWithEmailPassword(email, password);
        if (response.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          // Обработка случая, когда ответ не содержит пользователя
          showDialog(
            context: context,
            builder: (context) => PlatformWarningElement(
              title: AppLocalizations.of(context)!.error,
              content: AppLocalizations.of(context)!.invalidCreds,
            ),
          );
        }
      } catch (e) {
        // Логирование ошибки
        print('Login error: $e');
        if (e is AuthException) {
          print('Auth error code: ${e.statusCode}');
          print('Auth error message: ${e.message}');
        }
        showDialog(
          context: context,
          builder: (context) => PlatformWarningElement(
            title: AppLocalizations.of(context)!.error,
            content: AppLocalizations.of(context)!.unknownError,
          ),
        );
      }
    } else {
      // Обработка случая, когда поля пустые
      showDialog(
        context: context,
        builder: (context) => PlatformWarningElement(
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(context)!.emptyFieldsError,
        ),
      );
    }
  }

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
                  AppLocalizations.of(context)!.signIn,
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
                      _isObscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                PlatformButton(
                  text: AppLocalizations.of(context)!.logIn, 
                  onTap: () => _login()
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dontHaveAccount, 
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => SignUpPage()
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.createAccount, 
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