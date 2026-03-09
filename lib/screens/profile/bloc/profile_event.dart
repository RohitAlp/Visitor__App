part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FirstNameEvent extends ProfileEvent {
  final String name;

  const FirstNameEvent(this.name);
  
  @override
  List<Object> get props => [name];
}

class LastNameEvent extends ProfileEvent {
  final String name;

  const LastNameEvent(this.name);
  
  @override
  List<Object> get props => [name];
}

class DOBEvent extends ProfileEvent {
  final DateTime dob;

  const DOBEvent(this.dob);
  
  @override
  List<Object> get props => [dob];
}

class EmailEvent extends ProfileEvent {
  final String email;

  const EmailEvent(this.email);
  
  @override
  List<Object> get props => [email];
}

class PhoneNumberEvent extends ProfileEvent {
  final String number;

  const PhoneNumberEvent(this.number);
  
  @override
  List<Object> get props => [number];
}

class TowerEvent extends ProfileEvent {
  final String tower;

  const TowerEvent(this.tower);
  
  @override
  List<Object> get props => [tower];
}

class FloorEvent extends ProfileEvent {
  final String floor;

  const FloorEvent(this.floor);
  
  @override
  List<Object> get props => [floor];
}

class WingEvent extends ProfileEvent {
  final String wing;

  const WingEvent(this.wing);
  
  @override
  List<Object> get props => [wing];
}

class SocietyNameEvent extends ProfileEvent {
  final String societyName;

  const SocietyNameEvent(this.societyName);
  
  @override
  List<Object> get props => [societyName];
}

class LocationEvent extends ProfileEvent {
  final String location;

  const LocationEvent(this.location);
  
  @override
  List<Object> get props => [location];
}

class ProfilePhotoEvent extends ProfileEvent {
  final String profilePhoto;

  const ProfilePhotoEvent(this.profilePhoto);
  
  @override
  List<Object> get props => [profilePhoto];
}

class SaveProfileEvent extends ProfileEvent {
  const SaveProfileEvent();
}

