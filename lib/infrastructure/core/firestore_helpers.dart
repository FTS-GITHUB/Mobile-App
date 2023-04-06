// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:local_walkers/domain/auth/i_auth_repository.dart';
// import 'package:local_walkers/domain/core/errors.dart';
// import 'package:local_walkers/infrastructure/di/injectable.dart';
//
// extension FirestoreX on FirebaseFirestore {
//   Future<DocumentReference> userDocument() async {
//     final userOption = await getIt<IAuthRepository>().getSignedInUser();
//     final user = userOption.getOrElse(() => throw NotAuthenticatedError());
//     return FirebaseFirestore.instance.collection('users').doc(
//           user.id.getOrCrash(),
//         );
//   }
// }
//
// extension DocumentReferenceX on DocumentReference {
//   CollectionReference get noteCollection => collection('notes');
// }
