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

  const Floor({
    required this.id,
    required this.tower,
    required this.wing,
    required this.floorNumber,
    required this.status,
  });
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
        const Floor(id: '1', tower: 'Tower A', wing: 'Wing A1', floorNumber: 'Floor 1', status: 'Active'),
        const Floor(id: '2', tower: 'Tower A', wing: 'Wing A1', floorNumber: 'Floor 2', status: 'Active'),
        const Floor(id: '3', tower: 'Tower A', wing: 'Wing A2', floorNumber: 'Floor 1', status: 'Inactive'),
        const Floor(id: '4', tower: 'Tower A', wing: 'Wing A2', floorNumber: 'Floor 2', status: 'Active'),
        const Floor(id: '5', tower: 'Tower B', wing: 'Wing B1', floorNumber: 'Floor 1', status: 'Active'),
        const Floor(id: '6', tower: 'Tower B', wing: 'Wing B1', floorNumber: 'Floor 2', status: 'Active'),
        const Floor(id: '7', tower: 'Tower B', wing: 'Wing B2', floorNumber: 'Floor 1', status: 'Active'),
        const Floor(id: '8', tower: 'Tower B', wing: 'Wing B2', floorNumber: 'Floor 2', status: 'Inactive'),
        const Floor(id: '9', tower: 'Tower C', wing: 'Wing C1', floorNumber: 'Floor 1', status: 'Active'),
        const Floor(id: '10', tower: 'Tower C', wing: 'Wing C1', floorNumber: 'Floor 2', status: 'Active'),
        const Floor(id: '11', tower: 'Tower C', wing: 'Wing C2', floorNumber: 'Floor 1', status: 'Active'),
        const Floor(id: '12', tower: 'Tower C', wing: 'Wing C2', floorNumber: 'Floor 2', status: 'Active'),
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
