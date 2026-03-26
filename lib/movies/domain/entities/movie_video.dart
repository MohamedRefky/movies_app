import 'package:equatable/equatable.dart';

class MovieVideo extends Equatable {
  final String key;
  final String site;
  final String type;
  final bool official;

  const MovieVideo({
    required this.key,
    required this.site,
    required this.type,
    required this.official,
  });

  @override
  List<Object?> get props => [key, site, type, official];
}
