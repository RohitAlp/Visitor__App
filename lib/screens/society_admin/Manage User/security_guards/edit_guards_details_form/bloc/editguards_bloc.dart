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
      emit(state.copyWith(guardName: event.guardID));
    });
    on<EditGuardEmailEvent>((event, emit) {
      emit(state.copyWith(guardName: event.email));
    });
    on<EditGuardMobileNumberEvent>((event, emit) {
      emit(state.copyWith(guardName: event.editGuradMobileNumber));
    });
    on<EditGuardAddressEvent>((event, emit) {
      emit(state.copyWith(guardName: event.address));
    });
  }
}
