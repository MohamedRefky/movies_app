import 'package:movies_app/movies/domain/entities/movie_video.dart';

class MovieVideoModel extends MovieVideo {
  const MovieVideoModel({
    required super.key,
    required super.site,
    required super.type,
    required super.official,
    
  });

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) {
    return MovieVideoModel(
      key: json['key'],
      site: json['site'],
      type: json['type'],
      official: json['official'],
    );
  }
}
