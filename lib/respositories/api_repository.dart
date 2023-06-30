import 'package:chopper/chopper.dart';
import 'package:picasso/apis/pexels_api.dart';
import 'package:picasso/constants.dart';

class APIRepository {
  final ChopperClient chopper;

  APIRepository()
      : chopper = ChopperClient(
          baseUrl: Uri.parse(Constants.baseURL),
          services: [PexelsService.create()],
        );

  Future<String?> fetchSearchResult(String query, int page, int perPage) async {
    final pexelsService = chopper.getService<PexelsService>();
    final response =
        await pexelsService.search(query: query, page: page, perPage: perPage);
    if (response.isSuccessful) {
      // Successful request
      return response.body;
    } else {
      // Error code received from server
      // final error = response.error;
      return null;
    }
  }
}
