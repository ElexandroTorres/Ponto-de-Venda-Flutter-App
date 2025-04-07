abstract class PaymentEvent {}

class StartPayment extends PaymentEvent {
  final double total;

  StartPayment(this.total);
}

class PaymentValueChanged extends PaymentEvent {
  final String inputValue;

  PaymentValueChanged(this.inputValue);
}

class SubmitPayment extends PaymentEvent {
  final List<Map<String, dynamic>> products;

  SubmitPayment(this.products);
}
