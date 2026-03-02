part of 'manage_floors_bloc.dart';

abstract class ManageFloorsEvent extends Equatable {
  const ManageFloorsEvent();

  @override
  List<Object> get props => [];
}

class SelectTowerEvent extends ManageFloorsEvent {
  final String tower;

  const SelectTowerEvent(this.tower);

  @override
  List<Object> get props => [tower];
}

class SelectWingEvent extends ManageFloorsEvent {
  final String wing;

  const SelectWingEvent(this.wing);

  @override
  List<Object> get props => [wing];
}

class UpdateSearchQueryEvent extends ManageFloorsEvent {
  final String query;

  const UpdateSearchQueryEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearFiltersEvent extends ManageFloorsEvent {
  const ClearFiltersEvent();
}

class LoadFloorsEvent extends ManageFloorsEvent {
  const LoadFloorsEvent();
}

class DeleteFloorEvent extends ManageFloorsEvent {
  final String floorId;

  const DeleteFloorEvent(this.floorId);

  @override
  List<Object> get props => [floorId];
}
