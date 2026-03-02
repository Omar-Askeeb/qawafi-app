import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/features/poem/data/models/poem_model.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';
import 'package:qawafi_app/features/storyProverb/data/models/proverbStoryModel.dart';

abstract interface class FavoriteRemoteDatasource {
  Future<List<PoemModel>> fetchMyPoemFav({
    required String userId,
  });
  // Future<List<PoemModel>> fetchMyFav({
  //   required String userId,
  // });

  Future<List<QuatrainModel>> fetchMyQuatrainFav({
    required String userId,
  });

  Future<List<ProverbStoryModel>> fetchMyProverbStoryFav({
    required String userId,
  });
}

class FavoriteRemoteDatasourceImpl implements FavoriteRemoteDatasource {
  final ApiClient client;

  FavoriteRemoteDatasourceImpl({required this.client});

  // @override
  // Future<List<PoemModel>> fetchMyFav({required String userId}) {
  //   // TODO: implement fetchMyFav
  //   throw UnimplementedError();
  // }

  @override
  Future<List<PoemModel>> fetchMyPoemFav({required String userId}) async {
    var response =
        await client.get(EndPoints.favoritePoem.replaceAll('{userId}', userId));
    return List<PoemModel>.from(
      json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
            (x) => PoemModel.fromJson(x),
          ),
    );
  }

  @override
  Future<List<ProverbStoryModel>> fetchMyProverbStoryFav(
      {required String userId}) async {
    var response = await client
        .get(EndPoints.favoriteProverbStory.replaceAll('{userId}', userId));
    return List<ProverbStoryModel>.from(
      json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
            (x) => ProverbStoryModel.fromJson(x),
          ),
    );
  }

  @override
  Future<List<QuatrainModel>> fetchMyQuatrainFav(
      {required String userId}) async {
    var response = await client
        .get(EndPoints.favoriteQuatrains.replaceAll('{userId}', userId));
    return List<QuatrainModel>.from(
      json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
            (x) => QuatrainModel.fromJson(x),
          ),
    );
  }
}
