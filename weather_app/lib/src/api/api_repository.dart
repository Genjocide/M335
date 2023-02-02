import 'package:dio/dio.dart';

class ApiRepository {
  final String? url;
  final Map? payload;

  ApiRepository({required this.url, this.payload});

  final Dio _dio = Dio();

  void get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    // ignore: unnecessary_this
    _dio.get(this.url).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
