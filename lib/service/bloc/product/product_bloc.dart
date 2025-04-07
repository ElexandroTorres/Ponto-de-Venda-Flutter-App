import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/domain/models/cart.dart';
import 'package:pontodevenda/domain/models/product.dart';
import 'package:pontodevenda/repository/product/product_repository.dart';
import 'package:pontodevenda/service/bloc/product/product_event.dart';
import 'package:pontodevenda/service/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<Product> _products = [];
  final Map<int, int> _productCounts = {};
  final Cart _cart = Cart();

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<LoadProductsEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        final products = await productRepository.fetchProducts();
        _products = products;
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Erro ao carregar produtos'));
      }
    });

    on<AddProductEvent>((event, emit) {
      int total = _cart.getTotalOfProducts();
      if (total >= 10) {
        emit(
          ProductAddUnavailable(
            "Você atingiu o limite de 10 itens na venda. Remova algum item para continuar.",
          ),
        );
        return;
      }

      _cart.addProduct(event.product);
      total++;

      emit(ProductAdded(total));
    });

    on<RemoveProductEvent>((event, emit) {
      int total = _cart.getTotalOfProducts();
      if (total == 0) {
        return;
      }

      _cart.removeProduct(event.product);
      total--;

      emit(ProductRemoved(total));
    });
  }

  List<Product> get products => _products;

  Map<Product, int> get productCounts => _cart.products;

  int get productsInCart => _cart.getTotalOfProducts();

  List<Product> get productsInCartA => _cart.getProductList();

  double get totalPrice => _cart.getTotalPrice();
}
