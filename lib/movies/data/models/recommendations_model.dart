import 'package:movies_app/movies/domain/entities/recommendations.dart';

class RecommendationsModel extends Recommendations {
  const RecommendationsModel({required super.id, super.backdropPath});

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsModel(
        id: json['id'],
        backdropPath:
            json['backdrop_path'] ?? '/19B3vwsPwLzHvSAo9uxC70QEkqW.jpg',
      );
}
