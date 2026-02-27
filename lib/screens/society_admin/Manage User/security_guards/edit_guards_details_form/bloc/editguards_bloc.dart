import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../../utils/enum.dart';

part 'editguards_event.dart';
part 'editguards_state.dart';

class EditguardsBloc extends Bloc<EditguardsEvent, EditguardsState> {
  EditguardsBloc() : super(const EditguardsState()) {
    on<EditGuardNameEvent>((event, emit) {
      emit(state.copyWith(guardName: event.guardName));
    });
    on<EditGuardIDEvent>((event, emit) {
      emit(state.copyWith(guardID: event.guardID));
    });
    on<EditGuardEmailEvent>((event, emit) {
      emit(state.copyWith(guardEmail: event.email));
    });
    on<EditGuardMobileNumberEvent>((event, emit) {
      emit(state.copyWith(guardMobileNumber: event.editGuradMobileNumber));
    });
    on<EditGuardAddressEvent>((event, emit) {
      emit(state.copyWith(guardAddress: event.address));
    });
    on<EditGuardPhotoEvent>((event, emit) {
      emit(state.copyWith(guardPhotoBase64: event.photoBase64));
    });
  }
}
