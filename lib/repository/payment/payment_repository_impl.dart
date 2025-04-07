import 'package:dio/dio.dart';
import 'package:pontodevenda/common/api/dio_api_client.dart';
import 'package:pontodevenda/repository/payment/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final DioApiClient apiClient;

  PaymentRepositoryImpl(this.apiClient);

  @override
  Future<bool> registerSale({
    required double total,
    required double paidAmount,
    required double change,
    required String paymentMethod,
    required List<Map<String, dynamic>> products,
  }) async {
    try {
      final response = await apiClient.dio.post(
        '/carts',
        data: {
          'total': total,
          'paidAmount': paidAmount,
          'change': change,
          'paymentMethod': paymentMethod,
          'products': products,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Erro ao registrar venda. Código: ${response.statusCode}',
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
