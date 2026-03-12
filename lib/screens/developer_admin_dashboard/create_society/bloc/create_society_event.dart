import 'package:equatable/equatable.dart';

abstract class SocietyEvent extends Equatable {
  const SocietyEvent();

  @override
  List<Object?> get props => [];
}

class SocietyNameChanged extends SocietyEvent {
  final String societyName;

  const SocietyNameChanged(this.societyName);

  @override
  List<Object?> get props => [societyName];
}

class RegistrationNumberChanged extends SocietyEvent {
  final String registrationNumber;

  const RegistrationNumberChanged(this.registrationNumber);

  @override
  List<Object?> get props => [registrationNumber];
}

class EstablishedYearChanged extends SocietyEvent {
  final String year;

  const EstablishedYearChanged(this.year);

  @override
  List<Object?> get props => [year];
}

class SaveSocietyPressed extends SocietyEvent {}
class StreetAddressChanged extends SocietyEvent {
  final String streetAddress;
  StreetAddressChanged(this.streetAddress);
}

class LandmarkChanged extends SocietyEvent {
  final String landmark;
  LandmarkChanged(this.landmark);
}

class CityChanged extends SocietyEvent {
  final String city;
  CityChanged(this.city);
}

class StateChanged extends SocietyEvent {
  final String state;
  StateChanged(this.state);
}

class PincodeChanged extends SocietyEvent {
  final String pincode;
  PincodeChanged(this.pincode);
}

class CountryChanged extends SocietyEvent {
  final String country;
  CountryChanged(this.country);
}