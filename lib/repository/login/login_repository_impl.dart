import 'package:dio/dio.dart';
import 'package:pontodevenda/common/api/dio_api_client.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final DioApiClient apiClient;

  LoginRepositoryImpl(this.apiClient);

  @override
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        return true;
      } else {
        throw Exception('Usuário ou senha inválidos.');
      }
    } on DioException catch (e) {
      final message = switch (e.type) {
        DioExceptionType.connectionTimeout => 'Tempo de conexão excedido.',
        DioExceptionType.sendTimeout => 'Tempo de envio excedido.',
        DioExceptionType.receiveTimeout => 'Tempo de resposta excedido.',
        DioExceptionType.badResponse =>
          'Erro do servidor: ${e.response?.statusCode}',
        DioExceptionType.cancel => 'Requisição cancelada.',
        DioExceptionType.connectionError => 'Erro de conexão com a internet.',
        _ => 'Erro inesperado: ${e.message}',
      };

      throw Exception(message);
    } catch (e) {
      throw Exception('Erro inesperado: ${e.toString()}');
    }
  }
}
