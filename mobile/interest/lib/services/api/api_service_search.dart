import 'package:dio/dio.dart';
import 'package:interest/utils/config.dart';

class ApiServiceSearch {
  final Dio _dio = Dio();

  ApiServiceSearch(){
    _dio.options.baseUrl = 'http://$apiBaseUrl:$apiBasePort/';
    //_dio.options.connectTimeout = Duration(seconds: 5);
  }

  Future<Response> searchUsersByNickname(String nicknamePart) async {
    try {
      return await _dio.get('/v1/search_users', queryParameters: {'nickname_part' : nicknamePart});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> filterUserByInterestsAndMotivations(List<String> interests, List<String> motivations) async {
    try {
      return await _dio.post('/v1/filter)search_users', data:{
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