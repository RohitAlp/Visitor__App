import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_society_event.dart';
import 'create_society_state.dart';

class SocietyBloc extends Bloc<SocietyEvent, SocietyState> {

  SocietyBloc() : super(const SocietyState()) {

    on<SocietyNameChanged>((event, emit) {
      emit(state.copyWith(
        societyName: event.societyName,
      ));
    });

    on<RegistrationNumberChanged>((event, emit) {
      emit(state.copyWith(
        registrationNumber: event.registrationNumber,
      ));
    });

    on<EstablishedYearChanged>((event, emit) {
      emit(state.copyWith(
        establishedYear: event.year,
      ));
    });

    on<SaveSocietyPressed>((event, emit) async {

      emit(state.copyWith(isSubmitting: true));

      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    });
  }
}