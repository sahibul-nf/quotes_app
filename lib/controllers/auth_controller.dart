import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/controllers/user_controller.dart';
import 'package:quotes_app/utils/local_storage.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/error_handling.dart';
import 'favorite_controller.dart';
import 'quotes_controller.dart';

enum AuthEvent { loggedOut, loggedIn, expired, none }

enum AuthState { loading, loaded, error, none }

final authProvider = ChangeNotifierProvider<AuthController>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);

  final userController = ref.watch(userProvider.notifier);

  return AuthController(
    ref,
    userController: userController,
    userRepository: userRepository,
    authRepository: authRepository,
  );
});

class AuthController extends ChangeNotifier {
  AuthController(
    this.ref, {
    required this.userController,
    required this.userRepository,
    required this.authRepository,
  });

  final UserRepository userRepository;
  final AuthRepository authRepository;
  final UserController userController;
  final Ref ref;

  AuthState _authState = AuthState.none;
  AuthEvent _authEvent = AuthEvent.none;
  String _errorMessage = '';

  AuthState get authState => _authState;
  AuthEvent get authEvent => _authEvent;
  String get errorMessage => _errorMessage;

  void setState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  void setAuthEvent(AuthEvent authEvent) {
    _authEvent = authEvent;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    setState(AuthState.loading);

    try {
      final res = await authRepository.signUp(email, password);

      User newUser = User(id: res.user!.id, email: res.user!.email!);

      await userRepository.createUser(newUser);

      setState(AuthState.loaded);
    } catch (e) {
      final err = ErrorHandling.getErrorMessage(e);
      setErrorMessage(err);
      setState(AuthState.error);
    }
  }

  Future<void> signIn(String email, String password) async {
    setState(AuthState.loading);

    try {
      final res = await authRepository.signIn(email, password);

      final storage = LocalStorage();
      await storage.setSession(res.session!);

      User authUser = User(id: res.user!.id, email: res.user!.email!);

      userController.setUser(authUser);

      setState(AuthState.loaded);
      setAuthEvent(AuthEvent.loggedIn);

      // invalidate providers
      ref.invalidate(getQuotesProvider);
      ref.invalidate(quotesProvider);
      ref.invalidate(favoriteProvider);
    } catch (e) {
      final err = ErrorHandling.getErrorMessage(e);
      setErrorMessage(err);
      setState(AuthState.error);
    }
  }

  Future<void> signOut() async {
    setState(AuthState.loading);

    try {
      await authRepository.signOut();

      final storage = LocalStorage();
      await storage.deleteSession();

      setState(AuthState.loaded);
      setAuthEvent(AuthEvent.loggedOut);

      debugPrint(_authEvent.toString());
    } catch (e) {
      final err = ErrorHandling.getErrorMessage(e);
      setErrorMessage(err);
      setState(AuthState.error);
    }
  }

  // Check if user is logged in or not
  void checkAuth() async {
    try {
      final storage = LocalStorage();
      final session = await storage.getSession();

      if (session == null) {
        signOut();
        return;
      }

      debugPrint("UserID: ${session.user.id}");
      User authUser = await userRepository.fetchUser(session.user.id);

      userController.setUser(authUser);

      setAuthEvent(AuthEvent.loggedIn);

      // invalidate providers
      ref.invalidate(getQuotesProvider);
      ref.invalidate(quotesProvider);
      ref.invalidate(favoriteProvider);

      debugPrint(_authEvent.toString());
    } catch (e) {
      final err = ErrorHandling.getErrorMessage(e);
      setErrorMessage(err);
      setState(AuthState.error);

      signOut();
    }
  }
}
