import 'package:dio/dio.dart';
import 'package:interest/utils/config.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ApiServiceUser {
  final Dio _dio = Dio();
  final Talker talker = Talker();

  ApiServiceUser(){
    _dio.options.baseUrl = 'http://$apiBaseUrl:$apiBasePort';
    //_dio.options.connectTimeout = Duration(seconds: 5);
    _dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
  }

  Future<Response> getUser(String userId) async {
    try {
      return await _dio.get('/v1/get_user$userId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> createUserProfile(Map<String, dynamic> userData) async {
    try {
      return await _dio.post('/v1/create_user_profile', data: userData);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    try {
      return await _dio.put('/v1/update_user_profile/$userId', data: updates);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> deleteUserProfile(String userId) async {
    try {
      return await _dio.delete('/v1/pungs_user_profile_data', data: {'user_id' : userId});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    return "Ошибка: ${e.response?.statusCode} - ${e.message}";
  }
}