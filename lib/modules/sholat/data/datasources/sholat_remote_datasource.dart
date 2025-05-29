import 'package:get/get.dart';

class SholatRemoteDatasource extends GetConnect {
  Future<Map<String, dynamic>> fetchData({
    required String url,
    Map<String, String>? query,
  }) async {
    Response response = await get(url, query: query);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // print("connection error: ${response.statusText}");
      return {};
    }
  }
}
