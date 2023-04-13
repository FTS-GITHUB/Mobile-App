import 'package:dropandgouser/domain/common/setting.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISettingRepository{
  Future<Either<ApiError, DropAndGoSetting?>> getAchievementSettings();
  Future<Either<ApiError, DropAndGoSetting?>> getGenderSettings();
  Future<Either<ApiError, DropAndGoSetting?>> getAgeSettings();
  Future<Either<ApiError, DropAndGoSetting?>> getCompleteProfileSettings();
  Future<Either<ApiError, DropAndGoSetting?>> getCreteAccountSettings();
  Future<Either<ApiError, DropAndGoSetting?>> getRecommendationSettings();
  Future<Either<ApiError, DropAndGoSetting?>> getSignupSuccessSettings();
}