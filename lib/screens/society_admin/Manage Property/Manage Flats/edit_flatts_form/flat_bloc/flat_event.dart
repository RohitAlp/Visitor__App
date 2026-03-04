part of 'flat_bloc.dart';

abstract class FlatEvent extends Equatable {
  const FlatEvent();

  @override
  List<Object> get props => [];
}

class InitializeTowersEvent extends FlatEvent {
  const InitializeTowersEvent();
}

class TowerChangedEvent extends FlatEvent {
  final String tower;
  
  const TowerChangedEvent(this.tower);
  
  @override
  List<Object> get props => [tower];
}

class WingChangedEvent extends FlatEvent {
  final String wing;
  
  const WingChangedEvent(this.wing);
  
  @override
  List<Object> get props => [wing];
}

class FloorChangedEvent extends FlatEvent {
  final String floor;
  
  const FloorChangedEvent(this.floor);
  
  @override
  List<Object> get props => [floor];
}

class FlatNumberChangedEvent extends FlatEvent {
  final String flatNumber;
  
  const FlatNumberChangedEvent(this.flatNumber);
  
  @override
  List<Object> get props => [flatNumber];
}

class UpdateFlatEvent extends FlatEvent {
  const UpdateFlatEvent();
}
