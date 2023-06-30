// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexels_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PexelsService extends PexelsService {
  _$PexelsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PexelsService;

  @override
  Future<Response<dynamic>> search({
    required String query,
    required int page,
    required int perPage,
  }) {
    final Uri $url = Uri.parse('https://api.pexels.com/v1/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
      'per_page': perPage,
    };
    final Map<String, String> $headers = {
      'Authorization':
          'bVigkzCGeHojiBVBmj7OsQ5fCA3L4s12HGiDhSkd0svwMeIbxjp3Ow8w',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
