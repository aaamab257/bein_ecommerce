import 'package:bein_ecommerce/core/api/api_consumer.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;

class HttpConsumer implements ApiConsumer{
  @override
  Future get(String path,Options option, {Map<String, dynamic>? queryParameters}) async {
    final response = await http
        .get(Uri.parse(path));
    return response;
  }

  @override
  Future post(String path,Object? body , Options options, { Map<String, dynamic>? queryParameters}) async {
    return await http.post(Uri.parse(path) , body: body);
  }

  @override
  Future put(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return await http.put(Uri.parse(path),body:body,);
  }



}