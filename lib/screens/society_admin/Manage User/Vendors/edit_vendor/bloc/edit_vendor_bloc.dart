import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../utils/enum.dart';

part 'edit_vendor_event.dart';
part 'edit_vendor_state.dart';

class EditVendorBloc extends Bloc<EditVendorEvent, EditVendorState> {
  EditVendorBloc() : super(EditVendorState()) {
    on<VenderNameEvent>((event, emit) {
      emit(state.copyWith(vendorName: event.name));
    });

    on<VenderEmailEvent> ((event, emit){
      emit(state.copyWith(vendorEmail: event.email));
    });

    on<VenderMobileNumberEvent> ((event, emit){
      emit(state.copyWith(vendorMobileNumber: event.mobileNumber));
    });
    on<VenderIdEvent> ((event, emit){
      emit(state.copyWith(vendorID: event.ID));
    });
    on<VenderAddressEvent> ((event, emit){
      emit(state.copyWith(vendorAddress: event.address));
    });
    on<VenderPhotoEvent> ((event, emit){
      emit(state.copyWith(vendorPhotoBase64: event.photoBase64));
    });
  }
}
