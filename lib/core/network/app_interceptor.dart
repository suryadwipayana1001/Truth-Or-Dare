import 'package:dio/dio.dart';
import '../core.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // set default headers
    options.headers.addAll({"content-type": "application/json; charset=utf-8"});
    options.headers.addAll({"Accept": "application/json"});

    //check param 'required_token'
    const requiredToken = 'required_token';
    if (options.headers.containsKey(requiredToken)) {
      // remove required_token from headers
      options.headers.remove(requiredToken);

      // add authorization token
      String token = '';

      token = locator<Session>().isToken;

      options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    return super.onRequest(options, handler);
  }
}
