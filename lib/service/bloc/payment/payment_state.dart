abstract class PaymentState {
  final double total;

  const PaymentState(this.total);
}

class PaymentInitial extends PaymentState {
  PaymentInitial(super.total);
}

class PaymentValid extends PaymentState {
  final String inputValue;
  final double paidAmount;
  final double change;
  final List<Map<String, dynamic>> products;

  PaymentValid(
    this.inputValue,
    this.paidAmount,
    this.change, {
    this.products = const [],
  }) : super(paidAmount - change);
}

class PaymentInvalid extends PaymentState {
  final String inputValue;

  PaymentInvalid(this.inputValue) : super(0);
}

class PaymentSubmitting extends PaymentState {
  PaymentSubmitting() : super(0);
}

class PaymentSuccess extends PaymentState {
  PaymentSuccess(super.total);
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message) : super(0);
}
