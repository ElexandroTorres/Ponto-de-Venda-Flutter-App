import 'package:pontodevenda/domain/models/product.dart';

abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent(this.product);
}

class RemoveProductEvent extends ProductEvent {
  final Product product;

  RemoveProductEvent(this.product);
}
