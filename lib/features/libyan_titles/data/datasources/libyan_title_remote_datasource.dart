import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/features/libyan_titles/data/models/libyan_title_model.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';

abstract interface class LibyanTitleRemoteDatasource {
  Future<List<LibyanTitleModel>> fetchLibyanTitles(
      {required int pageNo, required int pageSize});

  Future<LibyanTitleModel> getTitleById({required String id});
}

class LibyanTitleRemoteDatasourceImpl implements LibyanTitleRemoteDatasource {
  final ApiClient client;

  LibyanTitleRemoteDatasourceImpl({required this.client});
  @override
  Future<List<LibyanTitleModel>> fetchLibyanTitles(
      {required int pageNo, required int pageSize}) async {
    try {
      var res = await client.get(
        EndPoints.libyanTitles
            .replaceAll('{pageNumber}', pageNo.toString())
            .replaceAll('{pageSize}', pageSize.toString()),
      );

      return List<LibyanTitleModel>.from(
        json.decode(utf8.decode(res.bodyBytes))["data"]['list'].map(
              (x) => LibyanTitleModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<LibyanTitleModel> getTitleById({required String id}) async {
    // TODO: implement getTitleById
    throw UnimplementedError();
  }
}
