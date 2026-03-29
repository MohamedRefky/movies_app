class ApiConstance {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '594e8be103e4d8968ebfc40bf0ebca3b';

  static const String nowPlayingMoviesPath =
      '$baseUrl/movie/now_playing?api_key=$apiKey';

  static const String popularMoviesPath =
      '$baseUrl/movie/popular?api_key=$apiKey';

  static const String topRatedMoviesPath =
      '$baseUrl/movie/top_rated?api_key=$apiKey';

  static String movieDetails(int movieId) =>
      '$baseUrl/movie/$movieId?api_key=$apiKey';

  static String movieRecommendations(int movieId) =>
      '$baseUrl/movie/$movieId/recommendations?api_key=$apiKey';

  static String movieVideos(int movieId) =>
      '$baseUrl/movie/$movieId/videos?api_key=$apiKey';
      
       static String getYouTubeVideoUrl(String videoKey) =>
      'https://www.youtube.com/watch?v=$videoKey';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => '$baseImageUrl$path';
}
