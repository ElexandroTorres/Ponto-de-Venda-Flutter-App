import 'package:dio/dio.dart';
import 'package:pontodevenda/common/api/dio_api_client.dart';
import 'package:pontodevenda/domain/models/user.dart';
import 'package:pontodevenda/repository/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DioApiClient apiClient;

  UserRepositoryImpl(this.apiClient);

  @override
  Future<List<User>> fetchUsers() async {
    try {
      final response = await apiClient.dio.get('/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          'Erro ao carregar usuários. Código: ${response.statusCode} - ${response.statusMessage}',
        );
      }
    } on DioException catch (exception) {
      final errorMessage = switch (exception.type) {
        DioExceptionType.connectionTimeout => 'Tempo de conexão excedido.',
        DioExceptionType.sendTimeout => 'Tempo de envio excedido.',
        DioExceptionType.receiveTimeout => 'Tempo de resposta excedido.',
        DioExceptionType.badResponse =>
          'Resposta inválida do servidor: ${exception.response?.statusCode}',
        DioExceptionType.cancel => 'Requisição cancelada.',
        DioExceptionType.connectionError => 'Erro de conexão com a internet.',
        _ => 'Erro inesperado: ${exception.message}',
      };

      throw Exception(errorMessage);
    } catch (exception) {
      throw Exception('Erro inesperado: ${exception.toString()}');
    }
  }
}
