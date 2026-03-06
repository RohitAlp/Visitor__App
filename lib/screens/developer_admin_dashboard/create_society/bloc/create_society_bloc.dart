import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../utils/enum.dart';

part 'create_society_event.dart';
part 'create_society_state.dart';

class CreateSocietyBloc extends Bloc<CreateSocietyEvent, CreateSocietyState> {
  CreateSocietyBloc() : super(CreateSocietyState()) {
    on<CreateSocietyEvent>((event, emit) {
     emit(state.copyWith());
    });
  }
}
