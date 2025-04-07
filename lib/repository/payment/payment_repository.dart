abstract class PaymentRepository {
  Future<bool> registerSale({
    required double total,
    required double paidAmount,
    required double change,
    required String paymentMethod,
    required List<Map<String, dynamic>> products,
  });
}
