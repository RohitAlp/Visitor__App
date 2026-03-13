import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/controller/society_controller.dart';
import 'package:visitorapp/model/AddSocietyResponse.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/utils.dart';
import '../../../../utils/enum.dart';
import 'create_society_event.dart';
import 'create_society_state.dart';

class SocietyBloc extends Bloc<SocietyEvent, SocietyState> {
  SocietyBloc() : super(const SocietyState()) {
    on<SocietyNameChanged>((event, emit) {
      emit(state.copyWith(societyName: event.societyName));
    });

    on<RegistrationNumberChanged>((event, emit) {
      emit(state.copyWith(registrationNumber: event.registrationNumber));
    });

    on<EstablishedYearChanged>((event, emit) {
      emit(state.copyWith(establishedYear: event.year));
    });

    on<StreetAddressChanged>((event, emit) {
      emit(state.copyWith(streetAddress: event.streetAddress));
    });

    on<LandmarkChanged>((event, emit) {
      emit(state.copyWith(landmark: event.landmark));
    });

    on<CityChanged>((event, emit) {
      emit(state.copyWith(city: event.city));
    });

    on<StateChanged>((event, emit) {
      emit(state.copyWith(state: event.state));
    });

    on<PincodeChanged>((event, emit) {
      emit(state.copyWith(pincode: event.pincode));
    });

    on<CountryChanged>((event, emit) {
      emit(state.copyWith(country: event.country));
    });

    on<SaveSocietyPressed>((event, emit) async {
      if (!await Utils.isConnected()) {
        emit(
          state.copyWith(
            submissionStatus: Status.error,
            errorMessage: Constant.internetConMsg,
          ),
        );
        return;
      }

      try {
        emit(
          state.copyWith(submissionStatus: Status.loading, isSubmitting: true),
        );
        SocietyController controller = SocietyController();

        Map<String, dynamic> jsonData = {
          "societyName": state.societyName,
          "registrationNo": state.registrationNumber,
          "address": state.streetAddress,
          "state": state.state,
          "city": state.city,
          "pinCode": state.pincode,
          "contact": "9881890989",
          "email": "ari@gmail.com",
          "taxNumber": "Tax9007",
        };

        final response = await controller.addSociety(jsonData);

        if (response != null) {
          AddSocietyResponse res = AddSocietyResponse.fromJson(response.data);

          if (res.status == true && res.statusCode == 200) {
            emit(
              state.copyWith(
                submissionStatus: Status.success,
                isSubmitting: false,
              ),
            );
          } else {
            emit(
              state.copyWith(
                submissionStatus: Status.error,
                isSubmitting: false,
                errorMessage: res.message,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              submissionStatus: Status.error,
              errorMessage: "Something went wrong",
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            submissionStatus: Status.error,
            isSubmitting: false,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
