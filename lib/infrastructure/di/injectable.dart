import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:dropandgouser/infrastructure/auth/firebase_auth_repository.dart';
import 'package:dropandgouser/infrastructure/services/firebase_storage_service.dart';
import 'package:dropandgouser/infrastructure/services/firestore_service.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
// final googleSignIn = GoogleSignIn();

void registerServices() {
  getIt.registerSingleton<NavigationService>(
    GoRouterNavigationService(),
  );
  getIt.registerLazySingleton<IAuthRepository>(()=>
    FirebaseAuthRepository(
      firebaseAuth,
    ),
  );

  getIt.registerLazySingleton<ICloudFirestoreRepository>(()=>
    FirestoreService(firestore),
  );

  getIt.registerLazySingleton<IStorageRepository>(
      ()=>
    FirebaseStorageRepository(firebaseStorage),
  );

  getIt.registerLazySingleton<Toasts>(()=>Toasts());
}
