import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_fibkovka/pages/add_working_page.dart';
import 'package:project_fibkovka/pages/home_page.dart';
import 'package:project_fibkovka/pages/signin_page.dart';
import 'package:project_fibkovka/pages/signup_page.dart';
import 'package:project_fibkovka/pages/update_working_page.dart';
import 'package:project_fibkovka/pages/working_page.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp().then((value) => print('Firebase Initialization Complete !!!!!!!!!!!!!!!'));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:_startPage(),    //_callStartPage(),
      routes: {
        HomePage.id:(context) => const HomePage(),
        SignInPage.id:(context) => const SignInPage(),
        SignUpPage.id:(context) => const SignUpPage(),
        WorkingPage.id:(context) => const WorkingPage(),
        //UpdateWorkingPage.id:(context) => UpdateWorkingPage(),
        AddWorkingPage.id:(context) => const AddWorkingPage(),
      },
    );
  }
  Widget _startPage(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return const WorkingPage();
          }else{
            return const SignInPage();
          }
        });
  }
}