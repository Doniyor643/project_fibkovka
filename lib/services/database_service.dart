
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_fibkovka/services/users.dart';

class DatabaseService{

  static Map map = {};
  Future addUserDates(String name, String family,String email, String password) async{
    // final uid = FirebaseAuth.instance.currentUser?.email;
    final referenceUsers = FirebaseFirestore.instance.collection('users').doc('$name $family');

    final users = Users(
        name: name,
        family: family,
        email: email,
        password: password);

    final json = users.toJson();
    await referenceUsers.set(json);
  }

  Stream<List<Users>> readUserDates()=>
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((dates) =>
        dates.docs.map((doc) => Users.fromJson(doc.data())).toList());

  // Foydalanuvchi ishlarini o'qish
  Stream<List<Work>> readUserWork()=>
      FirebaseFirestore.instance
          .collection('works')
          .snapshots()
          .map((dates) =>
          dates.docs.map((doc) => Work.fromJson(doc.data())).toList());

  Future<Users?> readUser({name,family})async{
    final docUser = FirebaseFirestore.instance.collection('users').doc("$name $family");
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return Users.fromJson(snapshot.data()!);
    }
    return null;
  }

  /// for Work

  Future addUserWork(String name, String summa,String text, String sizes,String number,String urlAddress) async{

    final referenceUsers = FirebaseFirestore.instance.collection('works').doc(name);

    final users = Work(
        name: name,
        summa: summa,
        text: text,
        size: sizes,
        number: number,
        urlAddress: urlAddress,
       );


    final json = users.toJson();
    map.addAll(json);
    await referenceUsers.set(json);
  }

  // Update Work

  Future updateUserWork(String name, String summa,String text, String sizes,String number,String urlAddress) async{

    final referenceUsers = FirebaseFirestore.instance.collection('works').doc(name);

    final users = Work(
      name: name,
      summa: summa,
      text: text,
      size: sizes,
      number: number,
      urlAddress: urlAddress,
    );

    final json = users.toJson();
    await referenceUsers.update(json);
  }
}