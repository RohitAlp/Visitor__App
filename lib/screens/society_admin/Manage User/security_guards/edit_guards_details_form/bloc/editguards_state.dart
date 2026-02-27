part of 'editguards_bloc.dart';

class EditguardsState extends Equatable {
  final String guardName;
  final String guardID;
  final String guardMobileNumber;
  final String guardEmail;
  final String guardAddress;
  final String? guardPhotoBase64;
  final Status status;
  final String? errorMessage;



  const EditguardsState({
    this.status = Status.initial,
     this.guardName = '',
     this.guardID = '',
     this.guardMobileNumber = '',
     this.guardEmail = '',
     this.guardAddress = '',
     this.guardPhotoBase64,
    this.errorMessage,

  });

  EditguardsState copyWith({
    final String? guardName ,
    final String? guardID,
    final String? guardMobileNumber,
    final String? guardEmail,
    final String? guardAddress,
    final String? guardPhotoBase64,
    String? errorMessage,

  }) {
    return EditguardsState(
      guardName: guardName ?? this.guardName,
      guardID: guardID ?? this.guardID,
      guardMobileNumber:
          guardMobileNumber ?? guardMobileNumber ?? this.guardMobileNumber,
      guardEmail: guardEmail ?? this.guardEmail,
      guardAddress: guardAddress ?? this.guardAddress,
      guardPhotoBase64: guardPhotoBase64 ?? this.guardPhotoBase64,
      errorMessage: errorMessage,

    );
  }

  @override
  List<Object?> get props => [guardName, guardID, guardMobileNumber, guardEmail, guardAddress, guardPhotoBase64, errorMessage];
}
