import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/features/reels/data/models/reel_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class ReelsRemoteDataSource {
  Future<List<ReelModel>> fetchReels();
}

class ReelsRemoteDataSourceImpl implements ReelsRemoteDataSource {
  final ApiClient client;

  ReelsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ReelModel>> fetchReels() async {
    // Replace with your API endpoint
    try {
      final response = await client.get(EndPoints.reels);

      return List<ReelModel>.from(
        json
            .decode(
              utf8.decode(response.bodyBytes),
            )['data']["list"]
            .map(
              (x) => ReelModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
