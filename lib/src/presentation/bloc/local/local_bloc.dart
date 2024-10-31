// BLoC - Handles locale changes
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/local/local_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/local/local_state.dart';

class LocalBloc extends Bloc<LocalEvent, LocalState> {
  LocalBloc() : super(LocalStateInitial()) {
    on<LocalChanged>((event, emit) async {
      try {
        emit(LocalUpdate(event.locale)); // Corrected this line to emit the locale update
      } catch (e) {
        // Assuming you want a failure state, you should define a state like LocalStateFailure
        emit(LocalStateFailure(message: "Failed to change locale"));
      }
    });
  }
}

// Optional Failure State if you want error handling
class LocalStateFailure extends LocalState {
  final String message;
  LocalStateFailure({required this.message}) : super(locale:Locale('en', '')); // Set default locale in case of failure
}