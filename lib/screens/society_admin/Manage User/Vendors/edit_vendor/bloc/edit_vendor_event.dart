part of 'edit_vendor_bloc.dart';

abstract class EditVendorEvent extends Equatable {
  const EditVendorEvent();

  @override
  List<Object> get props => [];
}

class VenderNameEvent extends EditVendorEvent {
  final String name;

  const VenderNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class VenderIdEvent extends EditVendorEvent {
  final String ID;
  const VenderIdEvent(this.ID);

  @override
  List<Object> get props => [ID];
}

class VenderMobileNumberEvent extends EditVendorEvent {
  final String mobileNumber;

  const VenderMobileNumberEvent(this.mobileNumber);

  @override
List<Object> get props => [mobileNumber];
}

class VenderEmailEvent extends EditVendorEvent{
  final String email;
  const VenderEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class VenderAddressEvent extends EditVendorEvent{
  final String address;

  const VenderAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

class VenderPhotoEvent extends EditVendorEvent {
  final String photoBase64;

  const VenderPhotoEvent(this.photoBase64);

  @override
  List<Object> get props => [photoBase64];
}

class UpdateVendorDetailsEvent extends EditVendorEvent {
  const UpdateVendorDetailsEvent();
}