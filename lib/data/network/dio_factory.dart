import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:it_bookstore/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration timeout = const Duration(minutes: 1);
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: headers);

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false));
    }

    return dio;
  }
}
