import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/repository/user/user_repository.dart';
import 'package:pontodevenda/service/bloc/user/user_event.dart';
import 'package:pontodevenda/service/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUsersEvent>((event, emit) async {
      try {
        emit(UserLoading());
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (_) {
        emit(UserError('Erro ao carregar os vendedores'));
      }
    });

    on<FilterUsersEvent>((event, emit) {
      if (state is UserLoaded) {
        final currentState = state as UserLoaded;
        final query = event.query.toLowerCase();

        final filtered =
            currentState.allUsers.where((user) {
              final fullName =
                  '${user.firstName} ${user.lastName}'.toLowerCase();
              return fullName.contains(query);
            }).toList();

        emit(UserLoaded(currentState.allUsers, filtered));
      }
    });
  }
}
