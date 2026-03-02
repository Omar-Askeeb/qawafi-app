import 'dart:convert';
import 'dart:developer';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/crpt/data/models/callerTonesCategoryModel.dart';
import 'package:qawafi_app/features/crpt/data/models/callerTonesModel.dart';
import 'package:qawafi_app/features/popularProverbs/data/models/popularProverbs.dart';
import '../../../../core/api/api_client2.dart';

abstract class CallerTonesRemoteDataSource {
  Future<List<CallerTonesModel>> CallerTonesById({required String Id});
  Future<List<CallerTonesCategoryModel>> CellerTonesCategoryByAlpha(
      {required String alphabet, required String gender});
}

class CallerTonesRemoteDataSourceImp extends CallerTonesRemoteDataSource {
  final ApiClient httpClient;

  CallerTonesRemoteDataSourceImp({required this.httpClient});

  @override
  Future<List<CallerTonesModel>> CallerTonesById(
      {required String Id}) async {
    try {
      var response =
          await httpClient.get(EndPoints.CellerTones.replaceAll('{Id}', Id));

      if (response.statusCode == 200) {
        // سجل الاستجابة للتحقق من هيكل البيانات
        log('Response: ${response.body}');

        var data = json.decode(utf8.decode(response.bodyBytes));

        if (data is Map<String, dynamic>) {
          return List<CallerTonesModel>.from(
            json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
                  (x) => CallerTonesModel.fromJson(x),
                ),
          );
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

  @override
  Future<List<CallerTonesCategoryModel>> CellerTonesCategoryByAlpha(
      {required String alphabet, required String gender}) async {
    try {
      var response = await httpClient.get(
          EndPoints.CellerTonesCategoury.replaceAll('{alphabet}', alphabet)
              .replaceAll('{gender}', gender));
      // سجل الاستجابة للتحقق من هيكل البيانات
      log('Response: ${response.body}');
      return List<CallerTonesCategoryModel>.from(
        json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
              (x) => CallerTonesCategoryModel.fromJson(x),
            ),
      );
    } catch (e) {
      // سجل الخطأ لتحليل المشكلة
      log('Error: $e');
      throw ServerException(e.toString());
    }
  }
}
