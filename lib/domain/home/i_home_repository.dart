import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:dropandgouser/domain/search/previous_searches.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class IHomeRepository {
  Future<Either<ApiError, List<Category>>> getCategories();

  Future<Either<ApiError, Category>> getCategory({
    required String categoryId,
  });

  Future<Either<ApiError, List<PreviousSearches>>> getPreviousSearches({
    required String userId,
  });

  Future<Either<ApiError, Unit>> uploadNewSearch({
    required String userId,
    required String searchText,
  });

  Future<Either<ApiError, Unit>> deleteSearch({
    required String userId,
    required String docId,
  });

  Future<Either<ApiError, List<Audio>>> getAudios({
    required AudioCategory category,
  });

  Future<Either<ApiError, UserData>> likeCategory({
    required String userId,
    required String categoryId,
  });

  Future<Either<ApiError, List<Audio>>> getDownloads();

  Future<Either<ApiError, Unit>> deleteDownloadedAudio({
    required String userId,
    required String docId,
  });

  Future<Either<ApiError, Unit>> addDownload({
    required String userId,
    required Audio audio,
  });
}
