part of 'profile_bloc.dart';



class ProfileState extends Equatable {
  final Status status;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String email;
  final String phoneNumber;
  final String tower;
  final String floor;
  final String wing;
  final String societyName;
  final String location;
  final String? profilePhoto;
  final String? errorMessage;
  final String? successMessage;

  const ProfileState({
    this.status = Status.initial,
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth,
    this.email = '',
    this.phoneNumber = '',
    this.tower = '',
    this.floor = '',
    this.wing = '',
    this.societyName = '',
    this.location = '',
    this.profilePhoto,
    this.errorMessage,
    this.successMessage,
  });

  ProfileState copyWith({
    Status? status,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? email,
    String? phoneNumber,
    String? tower,
    String? floor,
    String? wing,
    String? societyName,
    String? location,
    String? profilePhoto,
    String? errorMessage,
    String? successMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tower: tower ?? this.tower,
      floor: floor ?? this.floor,
      wing: wing ?? this.wing,
      societyName: societyName ?? this.societyName,
      location: location ?? this.location,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    firstName,
    lastName,
    dateOfBirth,
    email,
    phoneNumber,
    tower,
    floor,
    wing,
    societyName,
    location,
    profilePhoto,
    errorMessage,
    successMessage,
  ];

}
