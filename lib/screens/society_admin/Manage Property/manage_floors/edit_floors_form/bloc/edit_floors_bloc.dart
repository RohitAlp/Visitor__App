import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../../utils/enum.dart';

part 'edit_floors_event.dart';
part 'edit_floors_state.dart';

class EditFloorsBloc extends Bloc<EditFloorsEvent, EditFloorsState> {
  EditFloorsBloc() : super(EditFloorsState()) {
    on<SelectFloorsTowerEvent>((event, emit) {
      emit(state.copyWith(selectedTower: event.selectedTower));
    });
    on<EditWingNameEvent>((event,emit){
      emit(state.copyWith(wingName: event.wingName));
    });
    on<EditFloorNameEvent>((event,emit){
      emit(state.copyWith(floorName: event.floorName));
    });
    on<EditFloorNumberEvent>((event,emit){
      emit(state.copyWith(floorNumber: event.floorNumber));
    });
    on<EditTotalFlatsEvent>((event,emit){
      emit(state.copyWith(totalFlats: event.totalFlats));
    });

    on<UpdateWingEvent>((event, emit) {
      emit(state.copyWith(status: Status.loading));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(status: Status.success));
      });
    });
  }
}
