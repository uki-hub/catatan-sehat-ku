import 'package:catatan_sehat_ku/src/models/database_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  DatabaseService.__();

  static final DatabaseService _ = DatabaseService.__();

  factory DatabaseService() => _;

  final databaseReference = FirebaseDatabase.instance.ref('/user-data');

  void readData() async {
    databaseReference.child('/').once().then((DatabaseEvent e) {
      print(e.snapshot.key);
      // e.snapshot.children.forEach((c) => print('Data: ${c.value}'));
    });
  }

  void syncUp(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // databaseReference.child(FirebaseAuth.instance.currentUser!.uid).set(
    //       DatabaseUserData(
    //         uid: uid,
    //         profile: UserProfile(
    //           name: 'name',
    //           email: email,
    //           photo: photo,
    //           theme: theme,
    //         ),
    //         data: UserData(
    //           weight: weight,
    //           blood: blood,
    //           sleep: sleep,
    //           cholesterol: cholesterol,
    //           memory: memory,
    //         ),
    //       ),
    //     );
  }

  void updateData() {
    databaseReference.child('/').update({'abc123': 'Jane Doe'});
  }

  void deleteData() {
    databaseReference.child('path/to/data').remove();
  }
}
