part of 'flat_bloc.dart';

class FlatState extends Equatable {
  final String selectedTower;
  final String selectedWing;
  final String selectedFloor;
  final String flatNumber;
  final List<String> availableTowers;
  final List<String> availableWings;
  final List<String> availableFloors;
  final bool isLoadingTowers;
  final bool isLoadingWings;
  final bool isLoadingFloors;
  final bool isFormValid;
  final String? errorMessage;
  final Status submissionStatus;

  const FlatState({
    this.selectedTower = '',
    this.selectedWing = '',
    this.selectedFloor = '',
    this.flatNumber = '',
    this.availableTowers = const [],
    this.availableWings = const [],
    this.availableFloors = const [],
    this.isLoadingTowers = false,
    this.isLoadingWings = false,
    this.isLoadingFloors = false,
    this.isFormValid = false,
    this.errorMessage,
    this.submissionStatus = Status.initial,
  });

  FlatState copyWith({
    String? selectedTower,
    String? selectedWing,
    String? selectedFloor,
    String? flatNumber,
    List<String>? availableTowers,
    List<String>? availableWings,
    List<String>? availableFloors,
    bool? isLoadingTowers,
    bool? isLoadingWings,
    bool? isLoadingFloors,
    bool? isFormValid,
    String? errorMessage,
    Status? submissionStatus,
  }) {
    return FlatState(
      selectedTower: selectedTower ?? this.selectedTower,
      selectedWing: selectedWing ?? this.selectedWing,
      selectedFloor: selectedFloor ?? this.selectedFloor,
      flatNumber: flatNumber ?? this.flatNumber,
      availableTowers: availableTowers ?? this.availableTowers,
      availableWings: availableWings ?? this.availableWings,
      availableFloors: availableFloors ?? this.availableFloors,
      isLoadingTowers: isLoadingTowers ?? this.isLoadingTowers,
      isLoadingWings: isLoadingWings ?? this.isLoadingWings,
      isLoadingFloors: isLoadingFloors ?? this.isLoadingFloors,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        selectedTower,
        selectedWing,
        selectedFloor,
        flatNumber,
        availableTowers,
        availableWings,
        availableFloors,
        isLoadingTowers,
        isLoadingWings,
        isLoadingFloors,
        isFormValid,
        errorMessage,
        submissionStatus,
      ];
}
