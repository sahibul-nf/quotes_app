import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class AuthRepository {
  final supabase = sp.Supabase.instance.client;

  Future<sp.AuthResponse> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<sp.AuthResponse> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<sp.AuthResponse> isLoggedIn(String sessionString) async {
    try {
      final response = await supabase.auth.recoverSession(sessionString);

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
