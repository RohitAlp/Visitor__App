part of 'create_society_bloc.dart';

class CreateSocietyState extends Equatable {
  final String? errorMessage;
  final Status status;

  const CreateSocietyState({this.errorMessage, this.status = Status.initial});

  CreateSocietyState copyWith({
    final String? errorMessage,

  }){
    return CreateSocietyState(
      errorMessage: errorMessage,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage,status];
}
