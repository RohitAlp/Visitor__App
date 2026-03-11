import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:visitorapp/controller/floor_controller.dart';

import '../../../../../../constants/constant.dart';
import '../../../../../../constants/utils.dart';
import '../../../../../../model/AddFloorResponse.dart';
import '../../../../../../utils/enum.dart';

part 'edit_floors_event.dart';
part 'edit_floors_state.dart';

class EditFloorsBloc extends Bloc<EditFloorsEvent, EditFloorsState> {
  EditFloorsBloc() : super(EditFloorsState()) {
    on<SelectFloorsTowerEvent>((event, emit) {
      emit(state.copyWith(selectedTower: event.selectedTower));
    });
    on<EditWingNameEvent>((event, emit) {
      emit(state.copyWith(wingName: event.wingName));
    });
    on<EditFloorNameEvent>((event, emit) {
      emit(state.copyWith(floorName: event.floorName));
    });
    on<EditFloorNumberEvent>((event, emit) {
      emit(state.copyWith(floorNumber: event.floorNumber));
    });
    on<EditTotalFlatsEvent>((event, emit) {
      emit(state.copyWith(totalFlats: event.totalFlats));
    });

    on<UpdateWingEvent>((event, emit) {
      emit(state.copyWith(status: Status.loading));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(status: Status.success));
      });
    });

    /*on<AddFloorEvent>((event, emit) {
      emit(state.copyWith(status: Status.loading));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(status: Status.success));
      });
    });*/

    on<AddFloorEvent>(_addFloor);
  }
  Future<void> _addFloor(
    AddFloorEvent event,
    Emitter<EditFloorsState> emit,
  ) async
  {
    if (!await Utils.isConnected()) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: Constant.internetConMsg,
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: Status.loading));

      Map<String, dynamic> data = {
        "wingId": 1,
        "floorNumber": state.floorNumber.toString(),
      };

      FloorController controller = FloorController();

      final response = await controller.addFloor(data);

      if (response != null) {
        AddFloorResponse res = AddFloorResponse.fromJson(response.data);

        if (res.success == true && res.statusCode == 200) {
          emit(state.copyWith(status: Status.success));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      } else {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: "Something went wrong",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }
}
