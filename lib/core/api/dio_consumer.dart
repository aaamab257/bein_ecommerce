import 'dart:convert';
import 'dart:io';

import 'package:bein_ecommerce/core/api/status_code.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import '../../config/localization/app_localization.dart';
import '../../features/splash/presentation/localization/local_bloc/local_cubit.dart';
import '../error/exception.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'package:bein_ecommerce/di.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoints.BASE_URL
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };

    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future get(String path, Options options,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path,
          queryParameters: queryParameters, options: options);

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return _handleResponseAsJson(response);
      } else {
        throw DioError(requestOptions: response.requestOptions);
      }
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path, Object? body, Options options,
      {bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters, data: body, options: options);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.badResponse:
        print(error.response?.statusCode);
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.confilct:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        throw const NoInternetConnectionException();
      case DioErrorType.badCertificate:
        throw const ConnectionException();
      case DioErrorType.connectionError:
        throw const ConnectionException();
      default:
        throw const InternalServerErrorException();
    }
  }
}
