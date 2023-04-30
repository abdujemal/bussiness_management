import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/data_src/database_data_src.dart';
import 'package:bussiness_management/data/repo/database_repo_impl.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockDocumentReference extends Mock implements DocumentReference {}

void main() {
  group("add customer usecase -", () {
    // final DatabaseRepo repo = DatabaseRepoImpl(DatabaseDataSrcImpl(
    //     firebaseAuth: FirebaseAuth.instance,
    //     firebaseFirestore: MockFirebaseFirestore(),
    //     firebaseStorage: FirebaseStorage.instance));
    // final BehaviorSubject<MockDocumentReference> _ds =
    //     BehaviorSubject<MockDocumentReference>();
    // test(
    //   'given AddCustomerUsecase when it is successfull it will return void',
    //   () async {
    //     when(MockFirebaseFirestore()
    //         .collection(FirebaseConstants.customers)
    //         .add({})).thenAnswer((_) async {
    //       return ;
    //     });
    //   },
    // );
    // test(
    //   'given AddCustomerUsecase when it is not successfull it will return Exception',
    //   () {},
    // );
  });
}
