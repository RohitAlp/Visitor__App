part of 'edit_floors_bloc.dart';

abstract class EditFloorsEvent extends Equatable{
  const EditFloorsEvent();

  List<Object> get props => [];
}

class SelectFloorsTowerEvent extends EditFloorsEvent{
  final String selectedTower;

  const SelectFloorsTowerEvent(this.selectedTower);
  List<Object> get props => [];
}

class EditWingNameEvent extends EditFloorsEvent{
  final String wingName;

  const EditWingNameEvent(this.wingName);
  List<Object> get props => [];
}
class EditFloorNameEvent extends EditFloorsEvent{
  final String floorName;

  const EditFloorNameEvent(this.floorName);
  List<Object> get props => [];
}
class EditFloorNumberEvent extends EditFloorsEvent{
  final int floorNumber;

  const EditFloorNumberEvent(this.floorNumber);
  List<Object> get props => [];
}
class EditTotalFlatsEvent extends EditFloorsEvent{
  final int totalFlats;

  const EditTotalFlatsEvent(this.totalFlats);
  List<Object> get props => [];
}
class UpdateWingEvent extends EditFloorsEvent{
  const UpdateWingEvent();
}

