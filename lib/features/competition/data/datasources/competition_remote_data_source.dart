import 'dart:convert';
import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import '../models/competition_model.dart';

abstract interface class CompetitionRemoteDataSource {
  Future<List<CompetitionModel>> getCompetitions();
  Future<CompetitionModel> getCompetitionContestants(String id);
  Future<bool> voteContestant(String trackId);
  Future<bool> unVoteContestant(String trackId);
}

class CompetitionRemoteDataSourceImpl implements CompetitionRemoteDataSource {
  final ApiClient client;

  CompetitionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CompetitionModel>> getCompetitions() async {
    try {
      final response = await client.get(EndPoints.competition);
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      
      if (responseData['status'] == 'Ok') {
        dynamic data = responseData['data'];
        List<dynamic> list;
        if (data is Map && data.containsKey('list')) {
          list = data['list'];
        } else if (data is List) {
          list = data;
        } else {
          return [];
        }
        return list.map((json) => CompetitionModel.fromJson(json)).toList();
      } else {
        throw ServerException(responseData['messages']?.first ?? 'Unknown error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CompetitionModel> getCompetitionContestants(String id) async {
    try {
      // Uses ApiClient's default headers to include the current user's token if available
      final response = await client.get(EndPoints.getCompetitionContestants(id));
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      if (responseData['status'] == 'Ok') {
        return CompetitionModel.fromJson(responseData['data']);
      } else {
        throw ServerException(responseData['messages']?.first ?? 'Unknown error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> voteContestant(String trackId) async {
    try {
      // Uses ApiClient's default headers which include the current user's token from localStorage
      final response = await client.post(
        EndPoints.voteContestant,
        body: jsonEncode({'trackId': trackId}),
      );
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      if (responseData['status'] == 'Ok') {
        return true;
      } else {
        throw ServerException(responseData['messages']?.first ?? 'Unknown error');
      }
    } on ServerException catch (e) {
      if (e is ConflictException) rethrow;
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> unVoteContestant(String trackId) async {
    try {
      // Uses ApiClient's default headers which include the current user's token from localStorage
      final response = await client.post(
        EndPoints.unVoteContestant,
        body: jsonEncode({'trackId': trackId}),
      );
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      if (responseData['status'] == 'Ok') {
        return true;
      } else {
        throw ServerException(responseData['messages']?.first ?? 'Unknown error');
      }
    } on ServerException catch (e) {
      if (e is ConflictException) rethrow;
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
