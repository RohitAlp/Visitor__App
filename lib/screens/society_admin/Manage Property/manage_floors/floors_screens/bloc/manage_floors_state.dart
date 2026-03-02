part of 'manage_floors_bloc.dart';

class ManageFloorsState extends Equatable {
  final List<Floor> allFloors;
  final String selectedTower;
  final String selectedWing;
  final String searchQuery;
  final Status status;
  final String? errorMessage;

  const ManageFloorsState({
    this.allFloors = const [],
    this.selectedTower = 'All',
    this.selectedWing = 'All',
    this.searchQuery = '',
    this.status = Status.initial,
    this.errorMessage,
  });

  // Get unique towers
  List<String> get towers {
    final towers = allFloors.map((floor) => floor.tower).toSet().toList();
    towers.sort();
    return ['All', ...towers];
  }

  // Get wings based on selected tower
  List<String> get wings {
    if (selectedTower == 'All') {
      final wings = allFloors.map((floor) => floor.wing).toSet().toList();
      wings.sort();
      return ['All', ...wings];
    } else {
      final wings = allFloors
          .where((floor) => floor.tower == selectedTower)
          .map((floor) => floor.wing)
          .toSet()
          .toList();
      wings.sort();
      return ['All', ...wings];
    }
  }

  // Filter floors based on selections
  List<Floor> get filteredFloors {
    return allFloors.where((floor) {
      final matchesTower = selectedTower == 'All' || floor.tower == selectedTower;
      final matchesWing = selectedWing == 'All' || floor.wing == selectedWing;
      final matchesSearch = searchQuery.isEmpty ||
          floor.tower.toLowerCase().contains(searchQuery.toLowerCase()) ||
          floor.wing.toLowerCase().contains(searchQuery.toLowerCase()) ||
          floor.floorNumber.toLowerCase().contains(searchQuery.toLowerCase()) ||
          floor.status.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesTower && matchesWing && matchesSearch;
    }).toList();
  }

  ManageFloorsState copyWith({
    List<Floor>? allFloors,
    String? selectedTower,
    String? selectedWing,
    String? searchQuery,
    Status? status,
    String? errorMessage,
  }) {
    return ManageFloorsState(
      allFloors: allFloors ?? this.allFloors,
      selectedTower: selectedTower ?? this.selectedTower,
      selectedWing: selectedWing ?? this.selectedWing,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        allFloors,
        selectedTower,
        selectedWing,
        searchQuery,
        status,
        errorMessage,
      ];
}
