import 'package:http/http.dart' as http;

class Networking {

  static const networkStatus = 'networkStatus';
  static const networkHeaders = 'networkHeaders';
  static const networkBody = 'networkBody';

  Future<Map<String, dynamic>> getRequest(String networkEndpoint) async {

    final internetLookup = await http.get(Uri.parse(networkEndpoint));

    return {
      Networking.networkStatus: internetLookup.statusCode,
      Networking.networkHeaders: internetLookup.headers,
      Networking.networkBody: internetLookup.body,
    };
  }

}