import 'package:flutter/material.dart';
import 'package:interest/features/home/home.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/sign_in/sign_in.dart';

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