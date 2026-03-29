import 'package:equatable/equatable.dart';

class Recommendations extends Equatable {
  const Recommendations({ this.backdropPath, required this.id});

  final String? backdropPath;
  final int id;

  @override
  List<Object?> get props => [backdropPath, id];
}
