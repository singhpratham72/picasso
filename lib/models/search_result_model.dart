import 'package:picasso/models/photo_model.dart';

class SearchResult {
  final int? totalResults;
  final int? page;
  final int? perPage;
  final List<Photo>? photos;
  final String? nextPage;

  SearchResult({
    this.totalResults,
    this.page,
    this.perPage,
    this.photos,
    this.nextPage,
  });

  SearchResult.fromJson(Map<String, dynamic> json)
      : totalResults = json['total_results'] as int?,
        page = json['page'] as int?,
        perPage = json['per_page'] as int?,
        photos = (json['photos'] as List?)
            ?.map((dynamic e) => Photo.fromJson(e as Map<String, dynamic>))
            .toList(),
        nextPage = json['next_page'] as String?;

  Map<String, dynamic> toJson() => {
        'total_results': totalResults,
        'page': page,
        'per_page': perPage,
        'photos': photos?.map((e) => e.toJson()).toList(),
        'next_page': nextPage
      };
}
