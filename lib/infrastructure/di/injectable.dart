import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:dropandgouser/infrastructure/services/firebase_storage_service.dart';
import 'package:dropandgouser/infrastructure/services/firestore_service.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
final firebaseAuth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;

void registerServices() {
  getIt.registerSingleton<NavigationService>(
    GoRouterNavigationService(),
  );
  getIt.registerSingleton<ICloudFirestoreRepository>(
    FirestoreService(firestore),
  );

  getIt.registerSingleton<IStorageRepository>(
    FirebaseStorageRepository(firebaseStorage),
  );
}
