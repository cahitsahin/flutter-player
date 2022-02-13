import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user/blocs/signIn/signin_event.dart';
import 'package:flutter_user/blocs/signIn/signin_state.dart';
import 'package:flutter_user/data/repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final Repository repo;
  bool isFetching = false;

  SignInBloc(this.repo) : super(const SignInInitialState()) {
    on<SignInFetchEvent>((event, emit) async => await _signIn(emit));
  }

  Future<void> _signIn(Emitter<SignInState> emit) async {
    emit(const SignInLoadingState(message: 'Loading SignIn'));
    final response = await repo.fetchSignIn();
    final token = response.body.token;
    if (token is String) {
      emit(SignInSuccessState(token: token));
    } else {
      emit(SignInErrorState(error: response));
    }
  }
}
