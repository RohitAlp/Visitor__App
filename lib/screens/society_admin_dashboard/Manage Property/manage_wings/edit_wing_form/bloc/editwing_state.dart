part of 'editwing_bloc.dart';

class EditwingState extends Equatable {
  final String selectedTower;
  final String wingName;
  final String wingStatus;
  final Status status;
  final String? errorMessage;

  const EditwingState({
    this.status = Status.initial,
    this.selectedTower = '',
    this.wingName = '',
    this.wingStatus = '',
    this.errorMessage,
  });

  EditwingState copyWith({
    String? selectedTower,
    String? wingName,
    String? wingStatus,
    Status? status,
    String? errorMessage,
  }) {
    return EditwingState(
      selectedTower: selectedTower ?? this.selectedTower,
      wingName: wingName ?? this.wingName,
      wingStatus: wingStatus ?? this.wingStatus,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [selectedTower, wingName, wingStatus, status, errorMessage];
}
