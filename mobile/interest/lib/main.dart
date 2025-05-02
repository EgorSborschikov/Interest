import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:interest/features/home/view/home_page.dart';
import 'package:interest/l10n/locale_provider.dart';
import 'package:interest/services/supabase/auth_gate.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:interest/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as Supabase;
import 'ui/themes/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider localeProvider = LocaleProvider();

  await Supabase.Supabase.initialize(
    url: supabaseUrl, 
    anonKey: supabaseKey
  );

  await localeProvider.loadLanguagePreference();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider)
      ],
      child: const InterestApp(),
      /*DevicePreview(
        enabled: true,
        builder: (context) => const InterestApp()
      ),*/
    ),
  );
}

class InterestApp extends StatelessWidget {
  const InterestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Interest',
      theme: themeProvider.isDarkTheme 
        ? darkTheme 
        : lightTheme,
      home: AuthGate()
    );
  }
}