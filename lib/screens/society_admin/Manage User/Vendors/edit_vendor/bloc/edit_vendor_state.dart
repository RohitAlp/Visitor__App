part of 'edit_vendor_bloc.dart';

class EditVendorState extends Equatable {
  final String vendorName;
  final String vendorID;
  final String vendorMobileNumber;
  final String vendorEmail;
  final String vendorAddress;
  final String? vendorPhotoBase64;
  final Status status;
  final String? errorMessage;

  const EditVendorState({
    this.status = Status.initial,
    this.vendorName = '',
    this.vendorID = '',
    this.vendorMobileNumber = '',
    this.vendorEmail = '',
    this.vendorAddress = '',
    this.vendorPhotoBase64,
    this.errorMessage,
  });

  EditVendorState copyWith({
    final String? vendorName,
    final String? vendorID,
    final String? vendorMobileNumber,
    final String? vendorEmail,
    final String? vendorAddress,
    final String? vendorPhotoBase64,
    String? errorMessage,
  }) {
    return EditVendorState(
      vendorName: vendorName ?? this.vendorName,
      vendorID: vendorID ?? this.vendorID,
      vendorMobileNumber:
      vendorMobileNumber ?? vendorMobileNumber ?? this.vendorMobileNumber,
      vendorEmail: vendorEmail ?? this.vendorEmail,
      vendorAddress: vendorAddress ?? this.vendorAddress,
      vendorPhotoBase64: vendorPhotoBase64 ?? this.vendorPhotoBase64,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    vendorName,
    vendorID,
    vendorMobileNumber,
    vendorEmail,
    vendorAddress,
    vendorPhotoBase64,
    errorMessage,
  ];
}
