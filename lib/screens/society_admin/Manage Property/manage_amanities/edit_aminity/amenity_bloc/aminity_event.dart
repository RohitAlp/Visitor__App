part of 'aminity_bloc.dart';

abstract class AminityEvent extends Equatable{
  const AminityEvent();

  @override
  List<Object> get props => [];
}

class AmenityNameChangedEvent extends AminityEvent {
  final String amenityName;
  
  const AmenityNameChangedEvent(this.amenityName);
  
  @override
  List<Object> get props => [amenityName];
}

class AmenityTypeChangedEvent extends AminityEvent {
  final String amenityType;
  
  const AmenityTypeChangedEvent(this.amenityType);
  
  @override
  List<Object> get props => [amenityType];
}

class LocationChangedEvent extends AminityEvent {
  final String location;
  
  const LocationChangedEvent(this.location);
  
  @override
  List<Object> get props => [location];
}

class StatusChangedEvent extends AminityEvent {
  final String status;
  
  const StatusChangedEvent(this.status);
  
  @override
  List<Object> get props => [status];
}

class StartTimeChangedEvent extends AminityEvent {
  final String startTime;
  
  const StartTimeChangedEvent(this.startTime);
  
  @override
  List<Object> get props => [startTime];
}

class EndTimeChangedEvent extends AminityEvent {
  final String endTime;
  
  const EndTimeChangedEvent(this.endTime);
  
  @override
  List<Object> get props => [endTime];
}

class MaxCapacityChangedEvent extends AminityEvent {
  final String maxCapacity;
  
  const MaxCapacityChangedEvent(this.maxCapacity);
  
  @override
  List<Object> get props => [maxCapacity];
}

class AmenityFeesChangedEvent extends AminityEvent {
  final String amenityFees;
  
  const AmenityFeesChangedEvent(this.amenityFees);
  
  @override
  List<Object> get props => [amenityFees];
}

class OpenDaysChangedEvent extends AminityEvent {
  final List<String> openDays;
  
  const OpenDaysChangedEvent(this.openDays);
  
  @override
  List<Object> get props => [openDays];
}

class UpdateAmenityEvent extends AminityEvent {
  const UpdateAmenityEvent();
}
