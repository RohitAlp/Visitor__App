part of 'editguards_bloc.dart';

abstract class EditguardsEvent extends Equatable{
  const EditguardsEvent();

  @override
   List<Object> get props => [];
}

class EditGuardNameEvent extends EditguardsEvent {
  final String guardName;

  const EditGuardNameEvent(this.guardName);

  @override
  List<Object> get props => [guardName];
}

class EditGuardIDEvent extends EditguardsEvent{
  final String guardID;

  const EditGuardIDEvent(this.guardID);
  @override
  List<Object> get props => [guardID];
}

class EditGuardMobileNumberEvent extends EditguardsEvent{
  final String editGuradMobileNumber;

  const EditGuardMobileNumberEvent(this.editGuradMobileNumber);

  @override
  List<Object> get props => [editGuradMobileNumber];
}

class EditGuardEmailEvent extends EditguardsEvent{
  final String email;

  const EditGuardEmailEvent(this.email);

  @override
  List<Object> get props=>[email];
}

class EditGuardAddressEvent extends EditguardsEvent{
  final String address;

  const EditGuardAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

class UpdateGuardDetailsEvent extends EditguardsEvent {
  const UpdateGuardDetailsEvent();
}