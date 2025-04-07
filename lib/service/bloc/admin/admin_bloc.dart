import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';
import '../../../repository/admin/admin_repository.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc(this.adminRepository) : super(AdminInitial()) {
    on<CancelSaleRequested>(_onCancelSaleRequested);
  }

  Future<void> _onCancelSaleRequested(
    CancelSaleRequested event,
    Emitter<AdminState> emit,
  ) async {
    if (event.cartId.trim().isEmpty) {
      emit(AdminFailure('Por favor, insira o ID do carrinho.'));
      return;
    }

    emit(AdminLoading());

    try {
      final success = await adminRepository.cancelSale(event.cartId);
      if (success) {
        emit(AdminSuccess('Venda cancelada com sucesso!'));
      } else {
        emit(AdminFailure('Erro ao cancelar a venda.'));
      }
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }
}
