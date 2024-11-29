import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<http.Response> getPost(String endPoint) async {
    var url = Uri.parse('$baseUrl$endPoint');
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }
}
