import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/features/auth/widgets/language_selected_button.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../services/supabase/auth_service.dart';
import '../../../home/view/home_page.dart';
import '../../sign_in/sign_in.dart';

///<summary>
///Экран регистрации
///</summary>

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscure = true;

  final authService = AuthService();

  // Контроллеры данных
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  void _register(BuildContext context) async {
    // Получаем значения из контроллеров
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _passwordConfirmController.text.trim();

    print("Password: '$password' vs Confirm: '$confirmPassword'"); 
    print("Email empty: ${email.isEmpty}, Password empty: ${password.isEmpty}");

    // Debug prints для проверки значений
    print("Email: $email");
    print("Password: $password");
    print("Confirm Password: $confirmPassword");

    // Проверка на пустые поля и совпадение паролей
    if (password == confirmPassword && email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await authService.signUpWithEmailPassword(email, password);
        if (response.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => PlatformWarningElement(
              title: AppLocalizations.of(context)!.error,
              content: AppLocalizations.of(context)!.invalidCreds,
            ),
          );
        }
      } catch (e) {
        print("Ошибка регистрации: $e");
        showDialog(
          context: context,
          builder: (context) => PlatformWarningElement(
            title: AppLocalizations.of(context)!.error,
            content: AppLocalizations.of(context)!.unknownError,
          ),
        );
      }
    } else {
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
      backgroundColor: theme.colorScheme.surface,
      appBar: PlatformAppBar(
        title: '',
        child: LanguageSelectedButton(),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                PlatformTextField(
                  label: AppLocalizations.of(context)!.email,
                  controller: _emailController,
                  placeholder: AppLocalizations.of(context)!.requeired,
                  obscure: false, 
                  focusNode: _emailFocusNode,
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
                  focusNode: _passwordFocusNode,
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
                      _isObscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    ),
                  ), 
                  focusNode: _passwordConfirmFocusNode,
                ),
                const SizedBox(height: 32.0),
                PlatformButton(
                  text: AppLocalizations.of(context)!.createAccount,
                  onTap: () => _register(context),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
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