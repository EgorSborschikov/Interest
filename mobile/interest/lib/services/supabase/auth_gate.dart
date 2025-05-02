import 'package:flutter/material.dart';
import 'package:interest/features/auth/sign_in/view/sign_in_page.dart';
import 'package:interest/features/home/view/home_page.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget{
  const AuthGate({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: const Center(
                child: PlatformProgressIndicator(),
              ),
            );
          }

          final session = snapshot.hasData ? snapshot.data!.session : null;

          if (session != null){
            return HomePage();
          } else {
            return SignInPage();
          }
        }
      ),
    );
  }
}