import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _localeKey = 'selected_locale';
  
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageLoadStarted>(_onLanguageLoadStarted);
    on<LanguageChanged>(_onLanguageChanged);
  }

  Future<void> _onLanguageLoadStarted(
    LanguageLoadStarted event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey);
      
      if (localeCode != null) {
        final locale = Locale(localeCode);
        emit(LanguageLoaded(locale));
      } else {
        emit(LanguageLoaded(const Locale('en')));
      }
    } catch (e) {
      emit(LanguageError('Failed to load language: $e'));
    }
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, event.locale.languageCode);
      emit(LanguageLoaded(event.locale));
    } catch (e) {
      emit(LanguageError('Failed to save language: $e'));
    }
  }
}
