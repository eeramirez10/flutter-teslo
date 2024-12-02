import 'package:teslo_shop/features/auth/domain/index.dart';
import 'package:teslo_shop/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) =>
      dataSource.checkAuthStatus(token);

  @override
  Future<User> login(String email, String password) =>
      dataSource.login(email, password);

  @override
  Future<User> register(String email, String password, String fullName) =>
      dataSource.register(email, password, fullName);
}
