import 'package:dio/dio.dart';
import 'package:interest/ui/components/user.dart';
import 'package:interest/utils/config.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = Talker();

class ApiServiceSearch {
  final Dio _dio = Dio();
  //final talker = TalkerFlutter.init();

  ApiServiceSearch() {
    _dio.options.baseUrl = 'http://$apiBaseUrl:$apiBasePort';
    _dio.options.headers = {'Content-Type': 'application/json'};
    _dio.options.connectTimeout = Duration(seconds: 5);
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

  Future<List<User>> searchUsersByNickname(String nicknamePart) async {
    try {
      final response = await _dio.get(
        '/v1/search_users', 
        queryParameters: {'nickname_part' : nicknamePart}
      );
      print('API Response: ${response.data}');
      return (response.data as List).map((userData) => User.fromJson(userData)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> filterUserByInterestsAndMotivations(List<String> interests, List<String> motivations) async {
    try {
      return await _dio.post('/v1/filter_search_users', data:{
        'interests' : interests,
        'motivations' : motivations
      });
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    return "Ошибка: ${e.response?.statusCode} - ${e.message}";
  }
}