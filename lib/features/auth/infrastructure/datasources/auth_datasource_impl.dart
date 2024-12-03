import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/domain/index.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_error.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status',
          options: Options(headers: {'Authorization': 'bearer $token'}));
      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            "token incorrecto", e.response?.statusCode ?? 401);
      }
      throw Exception();
    } catch (e){
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Crendeciales incorrectas',
            e.response?.statusCode ?? 400);
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisas conexion a internet', 400);
      }

      throw CustomError('Something wrong happend', 500);
    } catch (e) {
      throw CustomError('Something wrong happend', 500);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
