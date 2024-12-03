import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/index.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_error.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()){
        checkAuthStatus();
      }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(microseconds: 500));

    try {
      final user = await authRepository.login(email, password);

      _setLogUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error desconocido');
    }
  }

  void registerUser(String email, String password, String fullName) async {}

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if(token == null || token.isEmpty) return logout();

    try{
      
      final user = await authRepository.checkAuthStatus(token);
      _setLogUser(user);

    }on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error desconocido');
    }

  }

  void _setLogUser(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }
}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
