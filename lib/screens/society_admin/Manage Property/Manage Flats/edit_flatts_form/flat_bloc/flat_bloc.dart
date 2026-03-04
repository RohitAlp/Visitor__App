import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:visitorapp/utils/enum.dart';

part 'flat_event.dart';
part 'flat_state.dart';

class FlatBloc extends Bloc<FlatEvent, FlatState> {
  FlatBloc() : super(FlatState()) {
    on<InitializeTowersEvent>((event, emit) async {
      await _loadTowers(emit);
    });
    
    on<TowerChangedEvent>((event, emit) async {
      emit(state.copyWith(
        selectedTower: event.tower,
        selectedWing: '',
        selectedFloor: '',
        isLoadingWings: true,
        availableWings: [],
        availableFloors: [],
      ));
      
      await _loadWingsForTower(event.tower, emit);
    });
    
    on<WingChangedEvent>((event, emit) async {
      emit(state.copyWith(
        selectedWing: event.wing,
        selectedFloor: '',
        isLoadingFloors: true,
        availableFloors: [],
      ));
      
      await _loadFloorsForWing(state.selectedTower, event.wing, emit);
    });
    
    on<FloorChangedEvent>((event, emit) {
      emit(state.copyWith(selectedFloor: event.floor));
      _validateForm(emit);
    });
    
    on<FlatNumberChangedEvent>((event, emit) {
      emit(state.copyWith(flatNumber: event.flatNumber));
      _validateForm(emit);
    });
    
    on<UpdateFlatEvent>((event, emit) {
      emit(state.copyWith(submissionStatus: Status.loading));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(submissionStatus: Status.success));
      });
    });
    
    add(const InitializeTowersEvent());
  }
  
  Future<void> _loadTowers(Emitter<FlatState> emit) async {
    emit(state.copyWith(isLoadingTowers: true));
    
    try {
      // TODO: Replace with actual API call
      // final response = await apiService.getTowers();
      // final towers = response.data;
      
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      final towers = ['Tower A', 'Tower B', 'Tower C'];
      
      emit(state.copyWith(
        availableTowers: towers,
        isLoadingTowers: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingTowers: false,
        errorMessage: 'Failed to load towers',
      ));
    }
  }
  
  // Future method for loading wings from API
  Future<void> _loadWingsForTower(String tower, Emitter<FlatState> emit) async {
    if (tower.isEmpty) {
      emit(state.copyWith(
        availableWings: [],
        isLoadingWings: false,
      ));
      return;
    }
    
    try {
      // TODO: Replace with actual API call
      // final response = await apiService.getWingsForTower(tower);
      // final wings = response.data;
      
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
      final wings = _getWingsForTower(tower);
      
      emit(state.copyWith(
        availableWings: wings,
        isLoadingWings: false,
      ));
      _validateForm(emit);
    } catch (e) {
      emit(state.copyWith(
        isLoadingWings: false,
        errorMessage: 'Failed to load wings for $tower',
      ));
    }
  }
  
  Future<void> _loadFloorsForWing(String tower, String wing, Emitter<FlatState> emit) async {
    if (tower.isEmpty || wing.isEmpty) {
      emit(state.copyWith(
        availableFloors: [],
        isLoadingFloors: false,
      ));
      return;
    }
    
    try {
      // TODO: Replace with actual API call
      // final response = await apiService.getFloorsForWing(tower, wing);
      // final floors = response.data;
      
      // Mock data for now
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
      final floors = _getFloorsForWing(tower, wing);
      
      emit(state.copyWith(
        availableFloors: floors,
        isLoadingFloors: false,
      ));
      _validateForm(emit);
    } catch (e) {
      emit(state.copyWith(
        isLoadingFloors: false,
        errorMessage: 'Failed to load floors',
      ));
    }
  }
  
  List<String> _getWingsForTower(String tower) {
    if (tower.isEmpty) return [];
    
    switch (tower) {
      case 'Tower A':
        return ['A-Wing', 'B-Wing', 'C-Wing'];
      case 'Tower B':
        return ['D-Wing', 'E-Wing'];
      case 'Tower C':
        return ['F-Wing', 'G-Wing', 'H-Wing'];
      default:
        return [];
    }
  }
  
  List<String> _getFloorsForWing(String tower, String wing) {
    if (tower.isEmpty || wing.isEmpty) return [];
    
    return ['Ground Floor', '1st Floor', '2nd Floor', '3rd Floor', '4th Floor', '5th Floor'];
  }
  
  void _validateForm(Emitter<FlatState> emit) {
    final isValid = state.selectedTower.isNotEmpty &&
                   state.selectedWing.isNotEmpty &&
                   state.selectedFloor.isNotEmpty &&
                   state.flatNumber.isNotEmpty;
    
    emit(state.copyWith(isFormValid: isValid));
  }
}
