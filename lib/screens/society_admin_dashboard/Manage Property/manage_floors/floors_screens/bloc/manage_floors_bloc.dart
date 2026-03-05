import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/enum.dart';

part 'manage_floors_event.dart';
part 'manage_floors_state.dart';

class Floor {
  final String id;
  final String tower;
  final String wing;
  final String floorNumber;
  final String status;
  final int totalFlats;
  final int occupiedFlats;

  const Floor({
    required this.id,
    required this.tower,
    required this.wing,
    required this.floorNumber,
    required this.status,
    required this.totalFlats,
    required this.occupiedFlats,
  });

  double get occupancyPercentage => totalFlats > 0 ? (occupiedFlats / totalFlats) * 100 : 0;
  String get occupancyText => '${occupancyPercentage.round()}% Occupied';
}

class ManageFloorsBloc extends Bloc<ManageFloorsEvent, ManageFloorsState> {
  ManageFloorsBloc() : super(const ManageFloorsState()) {
    // Register event handlers
    on<LoadFloorsEvent>(_onLoadFloors);
    on<SelectTowerEvent>(_onSelectTower);
    on<SelectWingEvent>(_onSelectWing);
    on<UpdateSearchQueryEvent>(_onUpdateSearchQuery);
    on<ClearFiltersEvent>(_onClearFilters);
    on<DeleteFloorEvent>(_onDeleteFloor);
  }

  Future<void> _onLoadFloors(
    LoadFloorsEvent event,
    Emitter<ManageFloorsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      // Simulate API call - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final List<Floor> floors = [
        const Floor(id: '1', tower: 'Tower A', wing: 'A Wing', floorNumber: 'Ground Floor', status: 'Active', totalFlats: 4, occupiedFlats: 4),
        const Floor(id: '2', tower: 'Tower A', wing: 'A Wing', floorNumber: 'Floor 1', status: 'Active', totalFlats: 4, occupiedFlats: 0),
        const Floor(id: '3', tower: 'Tower A', wing: 'B Wing', floorNumber: 'Ground Floor', status: 'Active', totalFlats: 4, occupiedFlats: 2),
        const Floor(id: '4', tower: 'Tower A', wing: 'B Wing', floorNumber: 'Floor 1', status: 'Inactive', totalFlats: 4, occupiedFlats: 1),
        const Floor(id: '5', tower: 'Tower B', wing: 'A Wing', floorNumber: 'Ground Floor', status: 'Active', totalFlats: 4, occupiedFlats: 4),
        const Floor(id: '6', tower: 'Tower B', wing: 'A Wing', floorNumber: 'Floor 1', status: 'Active', totalFlats: 4, occupiedFlats: 3),
        const Floor(id: '7', tower: 'Tower B', wing: 'B Wing', floorNumber: 'Ground Floor', status: 'Active', totalFlats: 4, occupiedFlats: 4),
        const Floor(id: '8', tower: 'Tower B', wing: 'B Wing', floorNumber: 'Floor 1', status: 'Active', totalFlats: 4, occupiedFlats: 2),
        const Floor(id: '9', tower: 'Tower C', wing: 'A Wing', floorNumber: 'Ground Floor', status: 'Active', totalFlats: 4, occupiedFlats: 4),
        const Floor(id: '10', tower: 'Tower C', wing: 'A Wing', floorNumber: 'Floor 1', status: 'Active', totalFlats: 4, occupiedFlats: 3),
        const Floor(id: '11', tower: 'Tower C', wing: 'B Wing', floorNumber: 'Ground Floor', status: 'Active', totalFlats: 4, occupiedFlats: 4),
        const Floor(id: '12', tower: 'Tower C', wing: 'B Wing', floorNumber: 'Floor 1', status: 'Active', totalFlats: 4, occupiedFlats: 1),
      ];

      emit(state.copyWith(
        allFloors: floors,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: 'Failed to load floors: ${e.toString()}',
      ));
    }
  }

  Future<void> _onSelectTower(
    SelectTowerEvent event,
    Emitter<ManageFloorsState> emit,
  ) async {
    emit(state.copyWith(
      selectedTower: event.tower,
      selectedWing: 'All', // Reset wing when tower changes
    ));
  }

  Future<void> _onSelectWing(
    SelectWingEvent event,
    Emitter<ManageFloorsState> emit,
  ) async {
    emit(state.copyWith(selectedWing: event.wing));
  }

  Future<void> _onUpdateSearchQuery(
    UpdateSearchQueryEvent event,
    Emitter<ManageFloorsState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<ManageFloorsState> emit,
  ) async {
    emit(state.copyWith(
      selectedTower: 'All',
      selectedWing: 'All',
      searchQuery: '',
    ));
  }

  Future<void> _onDeleteFloor(
    DeleteFloorEvent event,
    Emitter<ManageFloorsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      // Simulate API call - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      final updatedFloors = state.allFloors
          .where((floor) => floor.id != event.floorId)
          .toList();

      emit(state.copyWith(
        allFloors: updatedFloors,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: 'Failed to delete floor: ${e.toString()}',
      ));
    }
  }
}
