part of 'edit_floors_bloc.dart';

class EditFloorsState extends Equatable{
  final String selectedTower;
  final String wingName;
  final String floorName;
  final int floorNumber;
  final int totalFlats;
  final Status status;
  final String? errorMessage;


  const EditFloorsState({
   this.selectedTower ='',
   this.wingName ='',
   this.floorName ='',
   this.floorNumber = 0,
   this.totalFlats = 0,
   this.errorMessage,
   this.status = Status.initial,
});

  EditFloorsState copyWith({
    final String? selectedTower,
    final String? wingName,
    final String? floorName,
    final int? floorNumber,
    final int? totalFlats,
    final Status? status,
    final String? errorMessage,
}){
    return EditFloorsState(
      selectedTower: selectedTower ?? this.selectedTower,
      wingName: wingName ?? this.wingName,
      floorName: floorName ?? this.floorName,
      floorNumber: floorNumber ?? this.floorNumber,
      totalFlats: totalFlats ?? this.totalFlats,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>[
    selectedTower,
    wingName,
    floorName,
    floorNumber,
    totalFlats,
    status,
    errorMessage,
  ];
}