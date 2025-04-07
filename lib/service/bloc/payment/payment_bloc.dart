import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/repository/payment/payment_repository.dart';
import 'package:pontodevenda/service/bloc/payment/payment_event.dart';
import 'package:pontodevenda/service/bloc/payment/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  double _total = 0.0;

  PaymentBloc(this.paymentRepository) : super(PaymentInitial(0)) {
    on<StartPayment>((event, emit) {
      _total = event.total;
      emit(PaymentInitial(_total));
    });

    on<PaymentValueChanged>((event, emit) {
      final input = event.inputValue.replaceAll(',', '.');
      final paid = double.tryParse(input) ?? 0.0;

      if (paid >= _total) {
        final change = paid - _total;
        emit(PaymentValid(input, paid, change));
      } else {
        emit(PaymentInvalid(input));
      }
    });

    on<SubmitPayment>((event, emit) async {
      final currentState = state;
      if (currentState is PaymentValid) {
        try {
          emit(PaymentSubmitting());

          final success = await paymentRepository.registerSale(
            total: currentState.total,
            paidAmount: currentState.paidAmount,
            change: currentState.change,
            paymentMethod: 'Dinheiro',
            products: event.products,
          );

          if (success) {
            emit(PaymentSuccess(currentState.total));
          } else {
            emit(PaymentFailure('Erro ao processar pagamento.'));
          }
        } catch (e) {
          emit(PaymentFailure('Falha na requisição: ${e.toString()}'));
        }
      }
    });
  }
}
