import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/data/auth_repository.dart';

class FirestoreRepository {
  final SupabaseClient _supabaseClient;

  FirestoreRepository(this._supabaseClient);

  Future<void> addUser(String userId, String name, String email) async {
    try {
      await _supabaseClient.from('users').insert({
        'id': userId,
        'name': name,
        'email': email,
        'total_points': 0,
      }).select(); // .select() is optional but recommended
    } catch (e) {
      rethrow;
    }
  }
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(ref.watch(supabaseProvider));
});
