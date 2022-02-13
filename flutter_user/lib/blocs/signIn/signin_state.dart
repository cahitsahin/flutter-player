abstract class SignInState {
  const SignInState();
}

class SignInInitialState extends SignInState {
  const SignInInitialState();
}

class SignInLoadingState extends SignInState {
  final String message;

  const SignInLoadingState({
    required this.message,
  });
}

class SignInSuccessState extends SignInState {
  final String token;

  const SignInSuccessState({
    required this.token,
  });
}

class SignInErrorState extends SignInState {
  final String error;

  const SignInErrorState({
    required this.error,
  });
}
