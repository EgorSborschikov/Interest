import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    try{
      return _supabase.auth.signInWithPassword(
        email: email,
        password: password
      );
    } catch (e){
      print("Sign in error: $e");
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmailPassword(String email, String password) async {
    try {
      return _supabase.auth.signUp(
        email: email,
        password: password
      );
    } catch (e) {
      print("Sign up error: $e");
      rethrow;
    }
  }

  Future<void> deleteAccount(String userId) async {
    await _supabase.auth.admin.deleteUser(userId);
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}