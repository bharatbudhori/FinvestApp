import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.loading()) {
    on<LoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) async {
    // emit(HomeState.loading());
    // await Future.delayed(const Duration(seconds: 3));  // Mimic API call delay
    emit(HomeState.loaded());
  }
}
