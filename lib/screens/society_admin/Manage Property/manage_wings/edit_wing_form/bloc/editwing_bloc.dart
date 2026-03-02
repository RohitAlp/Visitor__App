import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/enum.dart';

part 'editwing_event.dart';
part 'editwing_state.dart';

class EditwingBloc extends Bloc<EditwingEvent, EditwingState> {
  EditwingBloc() : super(const EditwingState()) {
    on<SelectTowerEvent>((event, emit) {
      emit(state.copyWith(selectedTower: event.tower));
    });
    on<EditWingNameEvent>((event, emit) {
      emit(state.copyWith(wingName: event.wingName));
    });
    on<SelectWingStatusEvent>((event, emit) {
      emit(state.copyWith(wingStatus: event.status));
    });
    on<UpdateWingEvent>((event, emit) {
      // Handle API call here
      emit(state.copyWith(status: Status.loading));
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(status: Status.success));
      });
    });
    on<ResetWingFormEvent>((event, emit) {
      emit(const EditwingState());
    });
  }
}
