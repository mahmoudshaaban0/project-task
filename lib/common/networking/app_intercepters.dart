import 'package:app_template/common/constants/app_constants.dart';
import 'package:dio/dio.dart';

class AppIntercepters extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[AppConstants.accept] = AppConstants.applicationJson;
    options.headers[AppConstants.contentType] = AppConstants.applicationJson;
    // options.headers[AppStrings.authorization] = 'Bearer ${AppManager.instance.getString(AppStrings.apiKey)}';
    super.onRequest(options, handler);
  }

  @override
  dynamic onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
  }
}
