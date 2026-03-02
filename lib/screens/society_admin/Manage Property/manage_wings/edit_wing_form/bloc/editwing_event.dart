part of 'editwing_bloc.dart';

abstract class EditwingEvent extends Equatable {
  const EditwingEvent();

  @override
  List<Object> get props => [];
}

class SelectTowerEvent extends EditwingEvent {
  final String tower;

  const SelectTowerEvent(this.tower);

  @override
  List<Object> get props => [tower];
}

class EditWingNameEvent extends EditwingEvent {
  final String wingName;

  const EditWingNameEvent(this.wingName);

  @override
  List<Object> get props => [wingName];
}

class SelectWingStatusEvent extends EditwingEvent {
  final String status;

  const SelectWingStatusEvent(this.status);

  @override
  List<Object> get props => [status];
}

class UpdateWingEvent extends EditwingEvent {
  const UpdateWingEvent();
}

class ResetWingFormEvent extends EditwingEvent {
  const ResetWingFormEvent();
}
