import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/search/previous_searches.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class IHomeRepository{
  Future<Either<ApiError, List<Category>>> getCategories();
  Future<Either<ApiError, List<PreviousSearches>>> getPreviousSearches({
    required String userId,
  });
}