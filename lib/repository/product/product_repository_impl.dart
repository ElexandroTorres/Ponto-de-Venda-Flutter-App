import 'package:dio/dio.dart';
import 'package:pontodevenda/common/api/dio_api_client.dart';
import 'package:pontodevenda/domain/models/product.dart';
import 'package:pontodevenda/repository/product/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DioApiClient apiClient;

  ProductRepositoryImpl(this.apiClient);

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await apiClient.dio.get('/products');

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
          'Erro ao carregar produtos. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      final message = switch (e.type) {
        DioExceptionType.connectionTimeout => 'Tempo de conexão excedido.',
        DioExceptionType.sendTimeout => 'Tempo de envio excedido.',
        DioExceptionType.receiveTimeout => 'Tempo de resposta excedido.',
        DioExceptionType.badResponse =>
          'Resposta inválida: ${e.response?.statusCode}',
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
