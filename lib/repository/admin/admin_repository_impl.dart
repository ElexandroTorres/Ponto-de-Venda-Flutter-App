import 'package:dio/dio.dart';
import 'package:pontodevenda/common/api/dio_api_client.dart';
import 'package:pontodevenda/repository/admin/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final DioApiClient apiClient;

  AdminRepositoryImpl(this.apiClient);

  @override
  Future<bool> cancelSale(String cartId) async {
    try {
      final response = await apiClient.dio.delete('/carts/$cartId');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Erro ao cancelar venda. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      final message = switch (e.type) {
        DioExceptionType.connectionTimeout => 'Tempo de conexão excedido.',
        DioExceptionType.sendTimeout => 'Tempo de envio excedido.',
        DioExceptionType.receiveTimeout => 'Tempo de resposta excedido.',
        DioExceptionType.badResponse =>
          'Resposta inválida do servidor: ${e.response?.statusCode}',
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
