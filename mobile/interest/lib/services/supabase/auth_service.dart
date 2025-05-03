import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _logger = Logger('AuthService');
  final SupabaseClient _supabase = Supabase.instance.client;
  
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    try{
      return _supabase.auth.signInWithPassword(
        email: email,
        password: password
      );
    } catch (e, stackTrace){
      _logger.severe("Sign in error:", e, stackTrace);
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmailPassword(String email, String password) async {
    try {
      return _supabase.auth.signUp(
        email: email,
        password: password
      );
    } catch (e, stackTrace) {
      _logger.severe("Sign in error:", e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteAccount(String userId) async {
    await _supabase.auth.admin.deleteUser(userId);
    _logger.severe("User delete");
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}