import 'package:equatable/equatable.dart';

import '../../../../utils/enum.dart';

class SocietyState extends Equatable {
  final String societyName;
  final String registrationNumber;
  final String establishedYear;

  final String streetAddress;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String country;

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? errorMessage;

  final Status submissionStatus;
  const SocietyState({
    this.societyName = '',
    this.registrationNumber = '',
    this.establishedYear = '',
    this.streetAddress = '',
    this.landmark = '',
    this.city = '',
    this.state = '',
    this.pincode = '',
    this.country = 'India',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage,
    this.submissionStatus = Status.initial,
  });

  SocietyState copyWith({
    String? societyName,
    String? registrationNumber,
    String? establishedYear,
    String? streetAddress,
    String? landmark,
    String? city,
    String? state,
    String? pincode,
    String? country,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    Status? submissionStatus,
  }) {
    return SocietyState(
      societyName: societyName ?? this.societyName,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      establishedYear: establishedYear ?? this.establishedYear,
      streetAddress: streetAddress ?? this.streetAddress,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    societyName,
    registrationNumber,
    establishedYear,
    streetAddress,
    landmark,
    city,
    state,
    pincode,
    country,
    isSubmitting,
    isSuccess,
    isFailure,
    errorMessage,
    submissionStatus,
  ];
}
