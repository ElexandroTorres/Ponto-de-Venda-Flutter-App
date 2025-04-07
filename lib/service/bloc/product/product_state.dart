import 'package:pontodevenda/domain/models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductAdded extends ProductState {
  final int totalItems;

  ProductAdded(this.totalItems);
}

class ProductRemoved extends ProductState {
  final int totalItems;

  ProductRemoved(this.totalItems);
}

class ProductAddUnavailable extends ProductState {
  final String message;

  ProductAddUnavailable(this.message);
}
