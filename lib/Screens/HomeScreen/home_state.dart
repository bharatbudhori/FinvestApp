import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool hasData;

  const HomeState({required this.isLoading, required this.hasData});

  factory HomeState.loading() =>
      const HomeState(isLoading: true, hasData: false);
  factory HomeState.loaded() =>
      const HomeState(isLoading: false, hasData: true);

  @override
  List<Object> get props => [isLoading, hasData];
}
