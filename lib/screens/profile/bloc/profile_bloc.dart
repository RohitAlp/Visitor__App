import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../utils/enum.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<FirstNameEvent>((event, emit) {
      emit(state.copyWith(firstName: event.name));
      print(event.name);
    });
    on<LastNameEvent>((event, emit) {
      emit(state.copyWith(lastName: event.name));
    });
    on<DOBEvent>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dob));
    });
    on<EmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PhoneNumberEvent>((event, emit) {
      emit(state.copyWith(phoneNumber: event.number));
    });
    on<TowerEvent>((event, emit) {
      emit(state.copyWith(tower: event.tower));
    });
    on<WingEvent>((event, emit) {
      emit(state.copyWith(wing: event.wing));
    });
    on<FloorEvent>((event, emit) {
      emit(state.copyWith(floor: event.floor));
    });
    on<SocietyNameEvent>((event, emit) {
      emit(state.copyWith(societyName: event.societyName));
    });
    on<LocationEvent>((event, emit) {
      emit(state.copyWith(location: event.location));
    });
    on<ProfilePhotoEvent>((event, emit) {
      emit(state.copyWith(profilePhoto: event.profilePhoto));
    });
    on<SaveProfileEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        // Simulate API call or save operation
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(
          status: Status.success,
          successMessage: 'Profile saved successfully',
        ));
      } catch (e) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: 'Failed to save profile: ${e.toString()}',
        ));
      }
    });
  }
}
