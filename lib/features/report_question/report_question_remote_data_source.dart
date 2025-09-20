import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quizapp/core/constants/constants.dart';
import 'package:quizapp/features/quiz/models/quiz_type.dart';
import 'package:quizapp/features/report_question/report_question_exception.dart';
import 'package:quizapp/utils/api_utils.dart';

class ReportQuestionRemoteDataSource {
  Future<void> reportQuestion({
    required QuizTypes quizType,
    required String questionId,
    required String message,
  }) async {
    try {
      final body = <String, String>{
        questionIdKey: questionId,
        messageKey: message,
      };

      final url = quizType == QuizTypes.multiMatch
          ? multiMatchReportQuestionUrl
          : reportQuestionUrl;

      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: await ApiUtils.getHeaders(),
      );

      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (responseJson['error'] as bool) {
        throw ReportQuestionException(
          errorMessageCode: responseJson['message'].toString(),
        );
      }
    } on SocketException catch (_) {
      throw ReportQuestionException(errorMessageCode: errorCodeNoInternet);
    } on ReportQuestionException catch (e) {
      throw ReportQuestionException(errorMessageCode: e.toString());
    } on Exception catch (_) {
      throw ReportQuestionException(errorMessageCode: errorCodeDefaultMessage);
    }
  }
}
