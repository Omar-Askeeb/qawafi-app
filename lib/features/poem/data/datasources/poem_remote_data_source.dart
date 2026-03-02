import 'dart:convert';
import 'dart:developer';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/data/models/poem_model.dart';

import '../../../../core/enums/search_keys.dart';

abstract interface class PoemRemoteDatasource {
  Future<PoemDataModel> getPoemByPurposeAndCategory({
    required String purpose,
    required String poemCategory,
    required int pageNo,
    required int pageSize,
  });

  Future<PoemModel> getPoemById({required String id});

  Future<PoemDataModel> getPoemByMelodyOrJustRecite({
    required String poemCategory,
    required String? melody,
  });

  Future<PoemDataModel> getPoemByPoetId({
    required String poetId,
  });

  Future<PoemDataModel> getMostStreamed();
  Future<PoemDataModel> getNewest();

  Future<PoemDataModel> searchPoems({
    required SearchKeys searchKey,
    required String searchValue,
    required int pageNo,
    required int pageSize,
  });

  Future<PoemModel> add2Favorite({required String poemId});
  Future<PoemModel> remove2Favorite({required String poemId});
}

class PoemRemoteDatasourceImpl implements PoemRemoteDatasource {
  final ApiClient client;

  PoemRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<PoemDataModel> getPoemByPurposeAndCategory({
    required String purpose,
    required String poemCategory,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      log(
        EndPoints.poem(poemCategory: poemCategory, purpose: purpose),
      );
      var res = await client.get(
        EndPoints.poem(
            poemCategory: poemCategory,
            purpose: purpose,
            pageNumber: pageNo,
            pageSize: pageSize),
      );
      log(
        EndPoints.poem(
            poemCategory: poemCategory,
            purpose: purpose,
            pageNumber: pageNo,
            pageSize: pageSize),
      );
      log(res.body);
      return PoemDataModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      log(e.toString());
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemDataModel> getPoemByMelodyOrJustRecite({
    required String poemCategory,
    required String? melody,
  }) async {
    try {
      var res = await client.get(
        EndPoints.poem(poemCategory: poemCategory, melodiesName: melody),
      );

      return PoemDataModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemDataModel> getMostStreamed() async {
    // TODO: implement getMostStreamed
    try {
      var res = await client.get(
        EndPoints.poemMostStreamed,
      );

      return PoemDataModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemDataModel> getNewest() async {
    // TODO: implement getNewest
    try {
      var res = await client.get(
        EndPoints.poemNewest,
      );

      return PoemDataModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemDataModel> getPoemByPoetId({required String poetId}) async {
    try {
      var res = await client.get(
        EndPoints.poem(poetId: poetId),
      );

      return PoemDataModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemDataModel> searchPoems({
    required SearchKeys searchKey,
    required String searchValue,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      String? title;
      String? beginning;
      String? keywords;
      String? melodiesName;
      String? purpose;

      switch (searchKey) {
        case SearchKeys.name:
          title = searchValue;
          break;
        case SearchKeys.beginning:
          beginning = searchValue;
          break;
        case SearchKeys.keyWords:
          keywords = searchValue;
          break;
        case SearchKeys.purpose:
          purpose = searchValue;
          break;
        case SearchKeys.melody:
          melodiesName = searchValue;
          break;
      }

      final url = EndPoints.poem(
        title: title,
        beginning: beginning,
        keywords: keywords,
        purpose: purpose,
        melodiesName: melodiesName,
        pageNumber: pageNo,
        pageSize: pageSize,
      );

      final res = await client.get(url);

      return PoemDataModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemModel> add2Favorite({required String poemId}) async {
    try {
      var res = await client.post(
        EndPoints.poemAddFavorite,
        body: jsonEncode(
          {"poemId": poemId},
        ),
      );

      return PoemModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemModel> remove2Favorite({required String poemId}) async {
    try {
      var res = await client.post(
        EndPoints.poemRemoveFavorite,
        body: jsonEncode(
          {"poemId": poemId},
        ),
      );

      return PoemModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoemModel> getPoemById({required String id}) async {
    try {
      var res = await client.get(
        EndPoints.poemById.replaceAll('{poemId}', id),
      );

      return PoemModel.fromJson(
        json.decode(utf8.decode(res.bodyBytes))["data"],
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
