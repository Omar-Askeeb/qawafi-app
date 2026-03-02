import 'dart:convert';
import 'dart:developer';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/popularProverbs/data/models/popularProverbs.dart';
import '../../../../core/api/api_client2.dart';

abstract class PopularProverbsRemoteDataSource {
  Future<List<PopularProverbsModel>> popularProverbsByAlpha(
      {required String alphabet});
  Future<PopularProverbsModel> popularProverbsByTitel({required String titel});
}

class PopularProverbsRemoteDataSourceImp
    extends PopularProverbsRemoteDataSource {
  final ApiClient httpClient;

  PopularProverbsRemoteDataSourceImp({required this.httpClient});

  @override
  Future<List<PopularProverbsModel>> popularProverbsByAlpha(
      {required String alphabet}) async {
    try {
      var response = await httpClient.get(EndPoints.popularProverbs.replaceAll('{alphabet}', alphabet));
      // سجل الاستجابة للتحقق من هيكل البيانات
      log('Response: ${response.body}');
      return List<PopularProverbsModel>.from(
        json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
              (x) => PopularProverbsModel.fromJson(x),
            ),
      );
      //   List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      //   if (data is List) {
      //     List<PopularProverbsModel> proverbsList = data.map((item) {
      //       return PopularProverbsModel.fromJson(item as Map<String, dynamic>);
      //     }).toList();

      //     return proverbsList;
      //   } else {
      //     throw ServerException('Data is not a list');
      //   }
      // } else {
      //   throw ServerException('Failed to load proverbs with status code: ${response.statusCode}');
    } catch (e) {
      // سجل الخطأ لتحليل المشكلة
      log('Error: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PopularProverbsModel> popularProverbsByTitel(
      {required String titel}) async {
    try {
      var response =
          await httpClient.get(EndPoints.popularProverbs + '/$titel');

      if (response.statusCode == 200) {
        // سجل الاستجابة للتحقق من هيكل البيانات
        log('Response: ${response.body}');

        var data = json.decode(utf8.decode(response.bodyBytes));

        if (data is Map<String, dynamic>) {
          return PopularProverbsModel.fromJson(data);
        } else {
          throw ServerException('Data is not a map');
        }
      } else {
        throw ServerException(
            'Failed to load proverb with status code: ${response.statusCode}');
      }
    } catch (e) {
      // سجل الخطأ لتحليل المشكلة
      log('Error: $e');
      throw ServerException(e.toString());
    }
  }
}
