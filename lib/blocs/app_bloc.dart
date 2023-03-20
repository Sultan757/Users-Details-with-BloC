import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_response_with_bloc/blocs/user_events.dart';
import 'package:users_response_with_bloc/blocs/user_states.dart';

import '../repos/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
