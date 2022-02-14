import 'json_provider.dart';

class Repository {
  final JsonProvider jsonProvider = JsonProvider();

  Future<dynamic> fetchSignIn(String name, String pass) async =>
      await jsonProvider.fetchSignIn(name, pass);
  Future<dynamic> fetchChannels(String token) async =>
      await jsonProvider.fetchChannels(token);
}
