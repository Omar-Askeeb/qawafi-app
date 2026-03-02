import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../models/spoken_proverb_model.dart';

abstract interface class SpokenProverbRemoteDatasource {
  Future<List<SpokenProverbCategoryModel>> fetchCategories();
  Future<List<SpokenProverbModel>> fetchSpokenProverbByCategory(
      {required String categoryId});
}

class SpokenProverbRemoteDatasourceImpl
    implements SpokenProverbRemoteDatasource {
  final ApiClient client;

  SpokenProverbRemoteDatasourceImpl({required this.client});
  @override
  Future<List<SpokenProverbCategoryModel>> fetchCategories() async {
    try {
      var response = await client.get(EndPoints.spokenProverbsCategory);
      return List<SpokenProverbCategoryModel>.from(
        json
            .decode(
              utf8.decode(response.bodyBytes),
            )['data']["list"]
            .map(
              (x) => SpokenProverbCategoryModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<List<SpokenProverbModel>> fetchSpokenProverbByCategory(
      {required String categoryId}) async {
    try {
      var response = await client
          .get(EndPoints.spokenProverbs.replaceAll('{categoryId}', categoryId));
      return List<SpokenProverbModel>.from(
        json
            .decode(
              utf8.decode(response.bodyBytes),
            )['data']["list"]
            .map(
              (x) => SpokenProverbModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
