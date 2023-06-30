import 'package:picasso/models/src_model.dart';

class Photo {
  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final Src? src;
  final bool? liked;
  final String? alt;

  Photo({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        width = json['width'] as int?,
        height = json['height'] as int?,
        url = json['url'] as String?,
        photographer = json['photographer'] as String?,
        photographerUrl = json['photographer_url'] as String?,
        photographerId = json['photographer_id'] as int?,
        avgColor = json['avg_color'] as String?,
        src = (json['src'] as Map<String, dynamic>?) != null
            ? Src.fromJson(json['src'] as Map<String, dynamic>)
            : null,
        liked = json['liked'] as bool?,
        alt = json['alt'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'avg_color': avgColor,
        'src': src?.toJson(),
        'liked': liked,
        'alt': alt
      };
}
