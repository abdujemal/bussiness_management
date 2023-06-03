import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/data_src/database_data_src.dart';
import 'package:bussiness_management/data/model/cutomer_model.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/data/repo/database_repo_impl.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:bussiness_management/domain/usecase/add_customer_usecase.dart';
import 'package:bussiness_management/get_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';

// import 'package:mockito/mockito.dart';

// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// class MockStorage extends Mock implements FirebaseStorage {}

// class MockCollectionReference extends Mock implements CollectionReference {}

// class MockDocumentReference extends Mock implements DocumentReference {}

// class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() async {
  FakeFirebaseFirestore? firestoreInstance;

  // MockDocumentSnapshot? mockDocumentSnapshot;
  // MockCollectionReference? mockCollectionReference;
  // MockDocumentReference? mockDocumentReference;

  MockFirebaseAuth? authInstance;

  MockFirebaseStorage? storageInstance;

  AddCustomerUsecase? addCustomerUsecase;

  setUpAll(() async {
    firestoreInstance = FakeFirebaseFirestore();

    // mockDocumentSnapshot = MockDocumentSnapshot();
    // mockCollectionReference = MockCollectionReference();
    // mockDocumentReference = MockDocumentReference();

    authInstance = MockFirebaseAuth();

    storageInstance = MockFirebaseStorage();

    DatabaseDataSrc dataSrc = DatabaseDataSrcImpl(
      firebaseAuth: authInstance!,
      firebaseFirestore: firestoreInstance!,
      firebaseStorage: storageInstance!,
    );

    DatabaseRepo databaseRepo = DatabaseRepoImpl(dataSrc);

    addCustomerUsecase = AddCustomerUsecase(databaseRepo);
  });

  // test('should return data when the call to remote source is successful.',
  //     () async {
  //   when(firestoreInstance!.collection('users'))
  //       .thenAnswer((_) => mockCollectionReference! as CollectionReference<Map<String, dynamic>>);
  //   when(mockDocumentReference!.get())
  //       .thenAnswer((_) async => mockDocumentSnapshot!);
  //   when(mockDocumentSnapshot!.data()).thenAnswer((_) => {
  //         'image': "image",
  //         'name': "name",
  //         'priority': "priority",
  //         'email': "email"
  //       }); //   //act
  //   final result = await UserRepo(firestoreInstance!).getData('user_id');  //   //assert
  //   expect(result, isA<UserModel>()); //userModel is a object th
  // });

  // firestoreInstance!.collection("Users").add({'name': 'Aj', 'age': 20});

  // final res = await addCustomerUsecase.call(
  //   AddCutomerParams(
  //     CustomerModel(
  //       gender: "M",
  //       name: "AJ",
  //       id: "SGFas",
  //       phone: "0912345904",
  //       sefer: "Sefer",
  //       kk: "kk",
  //       location: "location",
  //       source: "source",
  //     ),
  //   ),
  // );
  // final snapshot =
  //     await firestoreInstance!.collection(FirebaseConstants.customers).get();
  // print(snapshot.docs.length); // 1
  // print(snapshot.docs.first['name']); // 'Bob'
  // print(firestoreInstance.dump());

  group("add customer usecase -", () {
    test(
      'given AddCustomerUsecase when it is successfull it will return void',
      () async {
        final res = await addCustomerUsecase!.call(
          AddCutomerParams(
            CustomerModel(
              gender: "M",
              name: "AJ",
              id: "SGFas",
              phone: "0912345904",
              sefer: "Sefer",
              kk: "kk",
              location: "location",
              source: "source",
            ),
          ),
        );

        expect(res.isRight(), true);
      },
    );
    test(
      'given AddCustomerUsecase when it is not successfull it will return Exception',
      () async {
        final customerModel = CustomerModel(
          gender: "M",
          name: "AJ",
          id: "SGFas",
          phone: "0912345904",
          sefer: "Sefer",
          kk: "kk",
          location: "location",
          source: "source",
        );

        // final res = await addCustomerUsecase!.call(
        //   AddCutomerParams(customerModel),
        // );

        when(firestoreInstance!
                .collection(FirebaseConstants.customers)
                .add(customerModel.toMap()))
            .thenThrow(FirebaseException(plugin: 'firestore'));

        expect(
            (await addCustomerUsecase!.call(
              AddCutomerParams(customerModel),
            )).isLeft(),
            true);
      },
    );
  });
}
