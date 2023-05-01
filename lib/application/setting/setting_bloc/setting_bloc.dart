import 'dart:async';

import 'package:dropandgouser/domain/common/setting.dart';
import 'package:dropandgouser/domain/i_setting_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

mixin GenderSettingBloc on Bloc<SettingEvent, SettingState> {}

mixin AgeSettingBloc on Bloc<SettingEvent, SettingState> {}

mixin CompleteProfileSettingBloc on Bloc<SettingEvent, SettingState> {}

mixin CreateAccountSettingBloc on Bloc<SettingEvent, SettingState> {}

mixin RecommendationSettingBloc on Bloc<SettingEvent, SettingState> {}

mixin SignupSuccessSettingBloc on Bloc<SettingEvent, SettingState> {}

class SettingBloc extends Bloc<SettingEvent, SettingState>
    with
        GenderSettingBloc,
        AgeSettingBloc,
        CompleteProfileSettingBloc,
        CreateAccountSettingBloc,
        RecommendationSettingBloc,
        SignupSuccessSettingBloc {
  SettingBloc({
    required this.settingRepository,
  }) : super(SettingStateInitial()) {
    on<FetchAchievementSettings>(_onFetchAchievementSettings);
    on<FetchGenderSettings>(_onFetchGenderSettings);
    on<FetchAgeSettings>(_onFetchAgeSettings);
    on<FetchCompleteProfileSettings>(_onFetchCompleteProfileSettings);
    on<FetchCreateAccountSettings>(_onFetchCreateAccountSettings);
    on<FetchRecommendationSettings>(_onFetchRecommendationSettings);
    on<FetchSignupSuccessSettings>(_onFetchSignupSuccessSettings);
  }

  final ISettingRepository settingRepository;

  Future<void> _onFetchAchievementSettings(
      FetchAchievementSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getAchievementSettings();
    response.fold(
      (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
      (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }

  Future<void> _onFetchGenderSettings(
      FetchGenderSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getGenderSettings();
    response.fold(
          (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
          (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }

  Future<void> _onFetchAgeSettings(
      FetchAgeSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getAgeSettings();
    response.fold(
          (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
          (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }
  Future<void> _onFetchCompleteProfileSettings(
      FetchCompleteProfileSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getCompleteProfileSettings();
    response.fold(
          (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
          (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }
  Future<void> _onFetchCreateAccountSettings(
      FetchCreateAccountSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getCreteAccountSettings();
    response.fold(
          (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
          (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }

  Future<void> _onFetchRecommendationSettings(
      FetchRecommendationSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getRecommendationSettings();
    response.fold(
          (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
          (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }

  Future<void> _onFetchSignupSuccessSettings(
      FetchSignupSuccessSettings event, Emitter<SettingState> emit) async {
    emit(SettingStateLoading());
    final response = await settingRepository.getSignupSuccessSettings();
    response.fold(
          (l) => emit(SettingStateError(
          message: l.message ?? "Couldn't connect, please try again")),
          (r) => emit(
        SettingStateLoaded(setting: r),
      ),
    );
  }


}
