import 'dart:convert';
import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/storyProverb/data/models/proverbStoryModel.dart';

import '../../domain/entities/proverbStory.dart';

abstract class ProverbStoryRemoteDataSource {
  Future<List<ProverbStoryModel>> getProverbStories(
      int pageNumber, int pageSize);
  Future<void> updateFavoriteStatus(String id, bool isFavorite);
  Future<ProverbStoryModel> getProverbStoryById(String id);
  Future<ProverbStory> add2Favorite(String id);
  Future<ProverbStory> removeFromFavorite(String id);
}

class ProverbStoryRemoteDataSourceImpl implements ProverbStoryRemoteDataSource {
  final ApiClient httpClient;

  ProverbStoryRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<ProverbStoryModel>> getProverbStories(
      int pageNumber, int pageSize) async {
    final response = await httpClient.get(
        '${EndPoints.Proverbstory}?pageNumber=$pageNumber&pageSize=$pageSize');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data']['list'];
      return jsonData.map((json) => ProverbStoryModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateFavoriteStatus(String id, bool isFavorite) async {
    final response;
    if (isFavorite == true) {
      response = await httpClient
          .get('${EndPoints.ProverbstoryFavorite}?proverbStoryId=$id');
    } else {
      response = await httpClient
          .get('${EndPoints.ProverbstoryUnFavorite}?proverbStoryId=$id');
    }

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<ProverbStoryModel> getProverbStoryById(String id) async {
    // TODO: implement getProverbStoriesById
    final response = await httpClient.get('${EndPoints.Proverbstory}/$id');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      return ProverbStoryModel.fromJson(jsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProverbStory> removeFromFavorite(String id) async {
    try {
      var res = await httpClient.post(EndPoints.storyProverbRemoveFromFavorite,
          body: jsonEncode({
            "proverbStoryId": id,
          }));
      return ProverbStoryModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))["data"]);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<ProverbStory> add2Favorite(String id) async {
    try {
      var res = await httpClient.post(EndPoints.StoryProverbAdd2Favorite,
          body: jsonEncode({
            "proverbStoryId": id,
          }));
      return ProverbStoryModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))["data"]);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
