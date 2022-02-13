import 'package:http/http.dart' as http;

class JsonProvider {
  Future<dynamic> fetchSignIn() async {
    var uri = "https://assessment-users-backend.herokuapp.com/users.json";
    try {
      return await http.get(Uri.parse(uri));
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchChannels() async {
    var uri = "http://devel.uniqcast.com:3001/channels";
    try {
      return await http.get(Uri.parse(uri));
    } catch (e) {
      return e.toString();
    }
  }
}
