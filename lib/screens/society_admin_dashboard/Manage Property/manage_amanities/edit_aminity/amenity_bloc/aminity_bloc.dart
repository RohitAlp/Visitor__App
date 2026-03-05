import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:visitorapp/utils/enum.dart';

part 'aminity_event.dart';
part 'aminity_state.dart';

class AminityBloc extends Bloc<AminityEvent, AminityState> {
  AminityBloc() : super(AminityState()) {
    on<AmenityNameChangedEvent>((event, emit) {
      emit(state.copyWith(amenityName: event.amenityName));
      _validateForm(emit);
    });
    
    on<AmenityTypeChangedEvent>((event, emit) {
      emit(state.copyWith(amenityType: event.amenityType));
      _validateForm(emit);
    });
    
    on<LocationChangedEvent>((event, emit) {
      emit(state.copyWith(location: event.location));
      _validateForm(emit);
    });
    
    on<StatusChangedEvent>((event, emit) {
      emit(state.copyWith(status: event.status));
      _validateForm(emit);
    });
    
    on<StartTimeChangedEvent>((event, emit) {
      emit(state.copyWith(startTime: event.startTime));
      _validateForm(emit);
    });
    
    on<EndTimeChangedEvent>((event, emit) {
      emit(state.copyWith(endTime: event.endTime));
      _validateForm(emit);
    });
    
    on<MaxCapacityChangedEvent>((event, emit) {
      emit(state.copyWith(maxCapacity: event.maxCapacity));
      _validateForm(emit);
    });
    
    on<AmenityFeesChangedEvent>((event, emit) {
      emit(state.copyWith(amenityFees: event.amenityFees));
      _validateForm(emit);
    });
    
    on<OpenDaysChangedEvent>((event, emit) {
      emit(state.copyWith(openDays: event.openDays));
      _validateForm(emit);
    });
    
    on<UpdateAmenityEvent>((event, emit) {
      emit(state.copyWith(submissionStatus: Status.loading));
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(submissionStatus: Status.success));
      });
    });
  }
  
  void _validateForm(Emitter<AminityState> emit) {
    final isValid = state.amenityName.isNotEmpty &&
                   state.amenityType.isNotEmpty &&
                   state.location.isNotEmpty &&
                   state.status.isNotEmpty &&
                   state.startTime.isNotEmpty &&
                   state.endTime.isNotEmpty;
    
    emit(state.copyWith(isFormValid: isValid));
  }
}
