import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quizapp/core/constants/constants.dart';
import 'package:quizapp/features/coin_history/coin_history_exception.dart';
import 'package:quizapp/utils/api_utils.dart';

class CoinHistoryRemoteDataSource {
  Future<({int total, List<Map<String, dynamic>> data})> getCoinHistory({
    required String limit,
    required String offset,
  }) async {
    try {
      //body of post request
      final body = <String, String>{limitKey: limit, offsetKey: offset};

      if (limit.isEmpty) body.remove(limitKey);

      if (offset.isEmpty) body.remove(offsetKey);

      final response = await http.post(
        Uri.parse(getCoinHistoryUrl),
        body: body,
        headers: await ApiUtils.getHeaders(),
      );

      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (responseJson['error'] as bool) {
        throw CoinHistoryException(
          errorMessageCode: responseJson['message'].toString(),
        );
      }

      return (
        total: int.parse(responseJson['total'] as String? ?? '0'),
        data: (responseJson['data'] as List).cast<Map<String, dynamic>>(),
      );
    } on SocketException catch (_) {
      throw CoinHistoryException(errorMessageCode: errorCodeNoInternet);
    } on CoinHistoryException catch (e) {
      throw CoinHistoryException(errorMessageCode: e.toString());
    } on Exception catch (_) {
      throw CoinHistoryException(errorMessageCode: errorCodeDefaultMessage);
    }
  }
}
