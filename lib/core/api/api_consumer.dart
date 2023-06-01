import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(String path, Options options, {Map<String, dynamic>? queryParameters });
  Future<dynamic> post(String path,Object? body,Options options,
      { Map<String, dynamic>? queryParameters});
  Future<dynamic> put(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters});
}