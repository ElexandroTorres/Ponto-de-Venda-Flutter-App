import 'package:pontodevenda/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}
