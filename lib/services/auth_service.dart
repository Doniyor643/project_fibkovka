
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/home_page.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user!.uid;
    }catch(error){
      print('ERROR IN SIGNING => $error');
      return null;
    }
  }

  Future registerEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user!.uid;
    }catch(error){
      print('ERROR IN REGISTER => $error');
      return null;
    }
  }

  Future logOut()async{
    await _firebaseAuth.signOut();
  }

  Future flutterToast(String text){
    return Fluttertoast.showToast(
        msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black54,
      fontSize: 16
    );
  }

  void login({required BuildContext context,String? email,String? password})async{

    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) => {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomePage()))
      });
    }on FirebaseAuthException catch(error){
      print(error.code.toString());
      String errors = error.code.toString();
      if(errors == 'user-not-found') {
        flutterToast("Login yoki parol xato");
      }
      if(errors == 'network-request-failed') {
        flutterToast("Server bilan aloqa uzilgan");
      }
    }
  }

}