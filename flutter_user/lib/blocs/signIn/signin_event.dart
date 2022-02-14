abstract class SignInEvent {
  const SignInEvent();
}

class SignInFetchEvent extends SignInEvent {
  final String name, password;
  const SignInFetchEvent(this.name, this.password);
}
