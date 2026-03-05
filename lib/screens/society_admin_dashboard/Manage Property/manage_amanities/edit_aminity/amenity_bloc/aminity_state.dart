part of 'aminity_bloc.dart';

class AminityState extends Equatable{
  final String amenityName;
  final String amenityType;
  final String location;
  final String status;
  final String startTime;
  final String endTime;
  final String maxCapacity;
  final String amenityFees;
  final List<String> openDays;
  final bool isFormValid;
  final String? errorMessage;
  final Status submissionStatus;

  const AminityState({
    this.amenityName = '',
    this.amenityType = '',
    this.location = '',
    this.status = 'Active',
    this.startTime = '',
    this.endTime = '',
    this.maxCapacity = '',
    this.amenityFees = '',
    this.openDays = const [],
    this.isFormValid = false,
    this.errorMessage,
    this.submissionStatus = Status.initial,
  });

  AminityState copyWith({
    String? amenityName,
    String? amenityType,
    String? location,
    String? status,
    String? startTime,
    String? endTime,
    String? maxCapacity,
    String? amenityFees,
    List<String>? openDays,
    bool? isFormValid,
    String? errorMessage,
    Status? submissionStatus,
  }) {
    return AminityState(
      amenityName: amenityName ?? this.amenityName,
      amenityType: amenityType ?? this.amenityType,
      location: location ?? this.location,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      amenityFees: amenityFees ?? this.amenityFees,
      openDays: openDays ?? this.openDays,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        amenityName,
        amenityType,
        location,
        status,
        startTime,
        endTime,
        maxCapacity,
        amenityFees,
        openDays,
        isFormValid,
        errorMessage,
        submissionStatus,
      ];
}
