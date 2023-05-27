import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalStorage {
  final _storage = const FlutterSecureStorage();

  Future<Session?> getSession() async {
    final session = await _storage.read(key: 'session');

    if (session != null) {
      return Session.fromJson(jsonDecode(session));
    }

    return null;
  }

  Future<void> setSession(Session session) async {
    await _storage.write(key: 'session', value: jsonEncode(session.toJson()));
  }

  Future<void> deleteSession() async {
    await _storage.delete(key: 'session');
  }
}
