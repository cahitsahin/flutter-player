import 'package:http/http.dart' as http;

class JsonProvider {
  Future<dynamic> fetchSignIn(String name, String pass) async {
    var uri = "http://devel.uniqcast.com:3001/auth/local";
    try {
      return await http
          .post(Uri.parse(uri), body: {"identifier": name, "password": pass});
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchChannels(String token) async {
    var uri = "http://devel.uniqcast.com:3001/channels";
    try {
      return await http.get(Uri.parse(uri));
    } catch (e) {
      return e.toString();
    }
  }
}
