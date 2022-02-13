import 'json_provider.dart';

class Repository {
  final JsonProvider jsonProvider = JsonProvider();

  Future<dynamic> fetchSignIn() async => await jsonProvider.fetchSignIn();
  Future<dynamic> fetchChannels() async => await jsonProvider.fetchChannels();
}
