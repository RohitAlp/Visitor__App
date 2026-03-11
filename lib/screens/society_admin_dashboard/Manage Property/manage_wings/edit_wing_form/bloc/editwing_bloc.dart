import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../constants/constant.dart';
import '../../../../../../constants/utils.dart';
import '../../../../../../controller/wing_controller.dart';
import '../../../../../../model/AddWingResponse.dart';
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

    on<AddWingEvent>((event, emit) async {
      if (!await Utils.isConnected()) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: Constant.internetConMsg,
        ));
        return;
      }

      try {
        emit(state.copyWith(status: Status.loading));

        Map<String, dynamic> data = {
          "wingName": state.wingName,
          "buildingId": event.buildingId,
        };

        WingController controller = WingController();

        final response = await controller.addWing(data);

        if (response != null) {
          AddWingResponse res = AddWingResponse.fromJson(response.data);

          if (res.status == true && res.statusCode == 200) {
            emit(state.copyWith(
              status: Status.success,
            ));
          } else {
            emit(state.copyWith(
              status: Status.error,
              errorMessage: res.message,
            ));
          }
        } else {
          emit(state.copyWith(
            status: Status.error,
            errorMessage: "Something went wrong!",
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: e.toString(),
        ));
      }
    });
    on<ResetWingFormEvent>((event, emit) {
      emit(const EditwingState());
    });
  }
}
