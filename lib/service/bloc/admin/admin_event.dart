abstract class AdminEvent {}

class CancelSaleRequested extends AdminEvent {
  final String cartId;

  CancelSaleRequested(this.cartId);
}