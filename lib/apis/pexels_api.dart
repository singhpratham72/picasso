import 'package:chopper/chopper.dart';

import '../constants.dart';

part "pexels_api.chopper.dart";

@ChopperApi(baseUrl: Constants.baseURL)
abstract class PexelsService extends ChopperService {
  static PexelsService create([ChopperClient? client]) =>
      _$PexelsService(client);

  @Get(path: "/search", headers: {"Authorization": Constants.apiKey})
  Future<Response> search({
    @Query('query') required String query,
    @Query('page') required int page,
    @Query('per_page') required int perPage,
  });
}
