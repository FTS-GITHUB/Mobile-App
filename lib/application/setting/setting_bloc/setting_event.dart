part of 'setting_bloc.dart';

abstract class SettingEvent{}

class FetchAchievementSettings extends SettingEvent{}

class FetchGenderSettings extends SettingEvent{}

class FetchAgeSettings extends SettingEvent{}

class FetchCompleteProfileSettings extends SettingEvent{}

class FetchCreateAccountSettings extends SettingEvent{}

class FetchRecommendationSettings extends SettingEvent{}

class FetchSignupSuccessSettings extends SettingEvent{}