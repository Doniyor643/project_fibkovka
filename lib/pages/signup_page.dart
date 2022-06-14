import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_fibkovka/pages/home_page.dart';
import 'package:project_fibkovka/services/auth_service.dart';
import 'package:project_fibkovka/services/database_service.dart';
import 'package:project_fibkovka/services/users.dart';
import 'package:project_fibkovka/pages/signin_page.dart';
class SignUpPage extends StatefulWidget {
  static const String id = 'signup_page';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DatabaseService service = DatabaseService();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // FibKov
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("FibKof",
                    style: GoogleFonts.jacquesFrancoisShadow(
                        fontSize: 50,
                        color: Colors.white
                    ),),
                  Container(
                    color: Colors.white,
                    height: 2,
                    width: 300,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Fibrabeton & Kofka",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white70
                    ),),
                ],
              )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 550,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        // Tizimga kirish
                        Container(
                          padding: const EdgeInsets.all(10),
                          // width: 300,
                          // height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0,3)
                                )
                              ],
                              color: Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Ro'yxatdan o'tish",
                                style: TextStyle(
                                    fontSize: 25
                                ),),
                              // Name
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                    labelText: 'Ismi'
                                ),
                              ),
                              const SizedBox(height: 15,),
                              // Family
                              TextField(
                                controller: familyController,
                                decoration: const InputDecoration(
                                    labelText: 'Familiyasi'
                                ),
                              ),
                              const SizedBox(height: 15,),
                              // Email
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    labelText: 'Email'
                                ),
                              ),
                              const SizedBox(height: 15,),
                              // Password
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    labelText: 'Password'
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25,),

                        ElevatedButton(
                            onPressed: (){
                              String email = emailController.text;
                              String password = passwordController.text;
                              String name = nameController.text;
                              String family = familyController.text;

                              service.addUserDates(name,family,email,password).then((value) => {
                                _register(),
                                Navigator.pushReplacementNamed(context, HomePage.id)
                              });
                            },
                            child: const SizedBox(
                                height: 50,
                                width: 275,
                                child: Center(child: Text("Ro'yxatdan o'tish",style: TextStyle(fontSize: 25),)))),
                        const SizedBox(height: 20,),
                        // SignUp navigator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Ro'yxatdan o'tganmisiz?",style: TextStyle(color: Colors.grey),),
                            TextButton(
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, SignInPage.id);
                              },
                              child: const Text("Kirish",),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future _register()async{
    String email = emailController.text;
    String password = passwordController.text;

    if(email.isEmpty || password.isEmpty) return;
    await authService.registerEmailAndPassword(email.trim(), password.trim()).then((value) => {
        emailController.clear(),
        passwordController.clear(),
        nameController.clear(),
        familyController.clear(),
    });



  }
}