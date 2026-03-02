import 'dart:convert';
import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/wordsMeaning/data/models/paginatedWords.dart';

abstract class WordRemoteDataSource {
  Future<PaginatedWordsModel> fetchWords(int pageNumber, int pageSize, String query);
}

class WordRemoteDataSourceImpl implements WordRemoteDataSource {
  final ApiClient httpClient;

  WordRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<PaginatedWordsModel> fetchWords(int pageNumber, int pageSize,String query) async {
    String q = query;
    String param = q.isEmpty ? '' : '&search=$q';
    final response = await httpClient.get('${EndPoints.getWordsMeaning}?pageNumber=$pageNumber&pageSize=$pageSize$param');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PaginatedWordsModel.fromJson(data);
    } else {
      throw ServerException('Failed to load words');
    }
  }
}
