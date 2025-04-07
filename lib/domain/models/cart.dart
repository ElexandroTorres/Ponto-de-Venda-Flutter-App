import 'package:pontodevenda/domain/models/product.dart';

class Cart {
  final Map<Product, int> _products = {};

  Map<Product, int> get products => _products;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] = _products[product]! + 1;
    } else {
      _products[product] = 1;
    }
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product)) {
      if (_products[product]! > 1) {
        _products[product] = _products[product]! - 1;
      } else {
        _products.remove(product);
      }
    }
  }

  int productQuantity(Product product) {
    return _products[product] ?? 0;
  }

  List<Product> getProductList() {
    List<Product> productList = [];
    _products.forEach((product, quantity) {
      for (int i = 0; i < quantity; i++) {
        productList.add(product);
      }
    });

    return productList;
  }

  int getTotalOfProducts() {
    int total = 0;
    _products.forEach((product, quantity) {
      total += quantity;
    });

    return total;
  }

  double getTotalPrice() {
    double totalPrice = 0;
    List<Product> productList = getProductList();
    for (var product in productList) {
      totalPrice += product.price;
    }

    return totalPrice;
  }
}
