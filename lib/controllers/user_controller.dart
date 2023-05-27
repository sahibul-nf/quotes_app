import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

final userProvider = StateNotifierProvider<UserController, User?>((ref) {
  return UserController();
});

class UserController extends StateNotifier<User?> {
  UserController(): super(null);
  
  void setUser(User? user) => state = user;

  // fetch user
  Future<void> fetchUser() async {
    state = null;
  }

  // update user
  Future<void> updateUser(User user) async {
    state = user;
  }

  // delete user
  Future<void> deleteUser() async {
    state = null;
  }
}