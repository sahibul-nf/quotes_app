import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

import '../models/user_model.dart';

class UserRepository {
  final supabase = sp.Supabase.instance.client;

  Future<void> createUser(User user) async {
    final data = user.toJson();

    try {
      await supabase.from('user_details').insert(data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // fetch user
  Future<User> fetchUser(String userId) async {
    try {
      final response = await supabase
          .from('user_details')
          .select()
          .eq('user_id', userId)
          .single();

      final user = User.fromJson(response);

      return user;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
