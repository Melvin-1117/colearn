import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Provider for Supabase Client Instance
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

class AuthRepository {
  final SupabaseClient _supabase; 

  AuthRepository(this._supabase);

  // Maps Supabase auth state changes to a Stream<User?>
  Stream<User?> get authStateChanges => _supabase.auth.onAuthStateChange.map((data) => data.session?.user);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException { // Use Supabase's specific exception
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _supabase.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(supabaseProvider));
});
